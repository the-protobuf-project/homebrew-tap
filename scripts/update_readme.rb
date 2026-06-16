#!/usr/bin/env ruby

require 'pathname'

repo_root = Pathname.new(__dir__).join('..').expand_path
readme_path = repo_root.join('README.md')

# Each section maps a source directory to the generated-list markers in the
# README. Add a new entry here if the tap ever grows another package type.
SECTIONS = [
  { dir: 'Formula', label: 'FORMULA' },
  { dir: 'Casks',   label: 'CASK' }
].freeze

# Pull the `desc "..."` line out of a formula/cask so the README list can show
# a one-line summary next to each package name.
def extract_desc(path)
  path.each_line do |line|
    return Regexp.last_match(1) if line =~ /^\s*desc\s+"(.*)"/
  end
  nil
end

def render_list(repo_root, dir)
  dir_path = repo_root.join(dir)
  return ['- None available yet.'] unless dir_path.directory?

  entries = Dir.children(dir_path)
               .select { |entry| entry.end_with?('.rb') }
               .sort
  return ['- None available yet.'] if entries.empty?

  entries.map do |entry|
    name = File.basename(entry, '.rb')
    desc = extract_desc(dir_path.join(entry))
    desc ? "- `#{name}` — #{desc}" : "- `#{name}`"
  end
end

readme = readme_path.read
updated = readme

SECTIONS.each do |section|
  start_marker = "<!-- BEGIN GENERATED #{section[:label]} LIST -->"
  end_marker = "<!-- END GENERATED #{section[:label]} LIST -->"

  unless updated.include?(start_marker) && updated.include?(end_marker)
    abort "README is missing #{section[:label]} list markers."
  end

  list = render_list(repo_root, section[:dir])
  replacement = ([start_marker] + list + [end_marker]).join("\n")
  pattern = /#{Regexp.escape(start_marker)}.*?#{Regexp.escape(end_marker)}/m
  updated = updated.sub(pattern, replacement)
end

if ARGV.include?('--check')
  exit(updated == readme ? 0 : 1)
end

readme_path.write(updated)
