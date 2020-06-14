require_relative './types/class'
require_relative './types/double'
require_relative './types/fieldref'
require_relative './types/float'
require_relative './types/integer'
require_relative './types/invoke_dynamic'
require_relative './types/long'
require_relative './types/method_handle'
require_relative './types/method_type'
require_relative './types/methodref'
require_relative './types/name_and_type'
require_relative './types/string'
require_relative './types/utf8'

require_relative '../debug_util'

module ConstantParser
  CONST_TYPES = {
    7 => ClassInfo,
    9 => FieldrefInfo,
    10 => MethodrefInfo,
    # 11 => InterfaceMethodrefInfo,
    8 => StringInfo,
    3 => IntegerInfo,
    4 => FloatInfo,
    5 => LongInfo,
    6 => DoubleInfo,
    12 => NameAndTypeInfo,
    1 => UTF8Info,
    15 => MethodHandleInfo,
    16 => MethodTypeInfo,
    18 => InvokeDynamicInfo,
  }

  def self.parse(data)
    tag = data[0].unpack('C')[0]
    info_klass = CONST_TYPES[tag]
    debug("tag: #{tag}, data(first 10byte): #{data[0..10].unpack('C10')}")
    info_klass.new(data)
  end
end
