require_relative './variable_struct'

# https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.7
class AttributeInfo < VariableStruct
  attr_reader :name

  u2  'attribute_name_index'
  u4  'attribute_length'
  var 'info'

  def initialize(data, constant_pool)
    attribute_name_index, attribute_length = data.unpack('nN')
    @struct_members = [
      Field.new('attribute_name_index', 2, attribute_name_index),
      Field.new('attribute_length', 4, attribute_length)
    ]

    info_value = data[6..-1].unpack("C#{attribute_length}")
    @struct_members << Field.new('info', attribute_length, info_value)
    # resolve name
    # > The constant_pool entry at attribute_name_index must be a CONSTANT_Utf8_info structure (§4.4.7) representing the name of the attribute
    # constat poolはクラスにしてIDEの補助を得られるようにしたほうが良さそう
    name_obj = constant_pool[attribute_name_index]
    raise RuntimeError("constant ##{attribute_name_index} is not UTF8 value") if name_obj.class != UTF8Info

    @name = name_obj.value
  end

end