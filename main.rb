#!/usr/bin/env ruby

require_relative './lib/class_file'
require 'pp'
f = open(ARGV[0]).read

class_file = ClassFile.new(f)
p class_file
