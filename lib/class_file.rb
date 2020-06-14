
# https://docs.oracle.com/javase/specs/jvms/se11/html/jvms-4.html#jvms-4.1

require_relative './constants/constant_parser'
require_relative './method_info'
require_relative './debug_util'

class ClassFile
  MAGIC_NUMBER = '0xCAFEBABE'.to_i(16)
  ACCESS_FLAGS = {
    ACC_PUBLIC: 0x0001,
    ACC_FINAL: 0x0010,
    ACC_SUPER: 0x0020,
    ACC_INTERFACE: 0x0200,
    ACC_ABSTRACT: 0x0400,
    ACC_SYNTHETIC: 0x1000,
    ACC_ANNOTATION: 0x2000,
    ACC_ENUM: 0x4000,
    ACC_MODULE: 0x8000
  }.freeze


  attr_reader :magic
  def initialize(file)
    parse(file)
  end

  def parse(inp)
    @magic, @minor_version, @major_version, @cp_count = inp.unpack('Nn3')
    if @magic != MAGIC_NUMBER
      warn "magic number mismatch(input: #{@magic}, expected: #{MAGIC_NUMBER})"
    end
    inp = inp[10..-1]

    @constant_pool = [123456] # padding
    inp = parse_constants(inp)

    # Access Flags
    @access_flags = inp.unpack('n')[0]
    @access_flag_names = parse_access_flags(@access_flags)
    inp = inp[2..-1]

    # Class Info
    @this_class, @super_class, @interfaces_count = inp.unpack('n3')
    inp = inp[6..-1]

    # Interfaces
    @interfaces = inp.unpack("n#{@interfaces_count}")
    inp = inp[@interfaces_count..-1]

    @fields_count = inp.unpack('n')[0]
    inp = inp[2..-1]

    @field_info = []
    inp = parse_fields(inp)

    @methods_count = inp.unpack('n')[0]
    inp = inp[2..-1]

    @method_info = []
    inp = parse_methods(inp)

    @attributes_count = inp.unpack('n')[0]
    inp = inp[2..-1]

    @attribute_info = []
    parse_attributes(inp)

  end

  def parse_access_flags(access_flags)
    flag_names = []
    ACCESS_FLAGS.each do |flag_name, mask|
      flag_names << flag_name if @access_flags & mask == mask
    end
    return flag_names
  end

  def parse_constants(inp)
    (@cp_count - 1).times do
      info = ConstantParser.parse(inp)
      @constant_pool << info
      ppdebug(info)
      debug("seek #{info.struct_size} byte")
      inp = inp[info.struct_size..-1]
    end
    return inp
  end

  def parse_fields(inp)
    @fields_count.times do
      info = FieldInfo.new(inp, @constant_pool)
      @field_info << info

      debug("seek #{info.struct_size} byte")
      inp = inp[info.struct_size..-1]
    end
    return inp
  end

  def parse_methods(inp)
    @methods_count.times do
      info = MethodInfo.new(inp, @constant_pool)
      @method_info << info

      debug("seek #{info.struct_size} byte")
      inp = inp[info.struct_size..-1]
    end
    return inp
  end

  def parse_attributes(inp)
    @attributes_count.times do
      info = AttributeInfo.new(inp, @constant_pool)
      @attribute_info << info

      debug("seek #{info.struct_size} byte")
      inp = inp[info.struct_size..-1]
    end
    return inp
  end
end

