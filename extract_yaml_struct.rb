#!/usr/bin/env ruby
require 'yaml'

def iterate(hash, level, keys = nil)
    hash.each do |key,value|

    element = value || key

    spacing = "  "*level

    keys = "" if not keys

    if element.is_a?(Hash)
      keys << "#{spacing}#{key}:\n"

      level += 1
      iterate(element, level, keys)
    else

      keys << "#{spacing}#{key}:\n"
    end
  end

  keys
end

if ARGV.size < 2
  puts "You must provide input and output filename"
  exit 1
end

input_filename = ARGV[0]
output_filename = ARGV[1]

yaml_data = YAML.load_file(input_filename)

level = 0

yaml_structure = iterate(yaml_data, level)

open(output_filename, 'w') { |output_file| output_file.puts(yaml_structure) }

