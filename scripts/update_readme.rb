#!/usr/bin/env ruby

require 'pathname'

repo_root = Pathname.new(__dir__).join('..').expand_path
readme_path = repo_root.join('README.md')
casks_dir = repo_root.join('Casks')

generated_start = '<!-- BEGIN GENERATED CASK LIST -->'
generated_end = '<!-- END GENERATED CASK LIST -->'

cask_names = Dir.children(casks_dir)
                .select { |entry| entry.end_with?('.rb') }
                .sort
                .map { |entry| File.basename(entry, '.rb') }

generated_list = if cask_names.empty?
                   ['- No casks available yet.']
                 else
                   cask_names.map { |name| "- `#{name}`" }
                 end

readme = readme_path.read
expected_section = ([generated_start] + generated_list + [generated_end]).join("\n")

if readme.include?(generated_start) && readme.include?(generated_end)
  updated = readme.sub(/<!-- BEGIN GENERATED CASK LIST -->.*?<!-- END GENERATED CASK LIST -->/m, expected_section)
else
  abort 'README is missing generated cask markers.'
end

if ARGV.include?('--check')
  exit(updated == readme ? 0 : 1)
end

readme_path.write(updated)