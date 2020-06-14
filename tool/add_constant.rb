#!/usr/bin/env ruby


inputs = []
loop do
  inp = gets.chomp
  break if inp.nil? || inp.empty?
  inputs << inp
end

class_name = inputs[0].match('CONSTANT_(.+)_info')[1]

puts "require_relative '../constant_info'\n\n"

puts "class #{class_name}Info < ConstantInfo"

inputs[1..-2].each do |line|
  res = line.match('^\s+(?<type>u\d)\s+(?<field_name>\w+);$')
  puts "  #{res[:type]} '#{res[:field_name]}'"
end

puts "end"
