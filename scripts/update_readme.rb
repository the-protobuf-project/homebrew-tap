#!/usr/bin/env ruby

require 'pathname'

repo_root = Pathname.new(__dir__).join('..').expand_path
readme_path = repo_root.join('README.md')

# Fully-qualified tap so the generated commands are copy-paste-able without a
# separate `brew tap` step.
TAP = 'the-protobuf-project/tap'

# Each section maps a source directory to the generated-list markers in the
# README. `cask: true` switches the install command to `brew install --cask`.
# Add a new entry here if the tap ever grows another package type.
SECTIONS = [
  { dir: 'Formula', label: 'FORMULA', cask: false },
  { dir: 'Casks',   label: 'CASK',    cask: true }
].freeze

# Pull the `desc "..."` line out of a formula/cask so the README can show a
# one-line summary next to each package.
def extract_desc(path)
  path.each_line do |line|
    return Regexp.last_match(1) if line =~ /^\s*desc\s+"(.*)"/
  end
  nil
end

# Render a Markdown table for a section: one row per package with its name, a
# one-line description, and a copy-paste `brew install` command. Casks use the
# `--cask` flag and a "Cask" header so the two tables read differently.
def render_table(repo_root, dir, cask:)
  dir_path = repo_root.join(dir)
  return ['_None available yet._'] unless dir_path.directory?

  entries = Dir.children(dir_path)
               .select { |entry| entry.end_with?('.rb') }
               .sort
  return ['_None available yet._'] if entries.empty?

  noun = cask ? 'Cask' : 'Formula'
  flag = cask ? '--cask ' : ''
  rows = entries.map do |entry|
    name = File.basename(entry, '.rb')
    # Escape pipes so a description never breaks the table layout.
    desc = extract_desc(dir_path.join(entry)).to_s.gsub('|', '\\|')
    command = "brew install #{flag}#{TAP}/#{name}"
    "| `#{name}` | #{desc} | `#{command}` |"
  end

  ["| #{noun} | Description | Install |", '| --- | --- | --- |'] + rows
end

readme = readme_path.read
updated = readme

SECTIONS.each do |section|
  start_marker = "<!-- BEGIN GENERATED #{section[:label]} LIST -->"
  end_marker = "<!-- END GENERATED #{section[:label]} LIST -->"

  unless updated.include?(start_marker) && updated.include?(end_marker)
    abort "README is missing #{section[:label]} list markers."
  end

  lines = render_table(repo_root, section[:dir], cask: section[:cask])
  body = lines.join("\n")
  replacement = "#{start_marker}\n\n#{body}\n\n#{end_marker}"
  pattern = /#{Regexp.escape(start_marker)}.*?#{Regexp.escape(end_marker)}/m
  updated = updated.sub(pattern, replacement)
end

if ARGV.include?('--check')
  exit(updated == readme ? 0 : 1)
end

readme_path.write(updated)
