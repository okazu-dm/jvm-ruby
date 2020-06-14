require_relative './variable_struct'
require_relative './attribute_info'

# https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.5
class FieldInfo < VariableStruct
  u2  'access_flags'
  u2  'name_index'
  u2  'descriptor_index'
  u2  'attributes_count'
  var 'attributes'

  def struct_size
    8 + @attributes.map(&:struct_size).inject(&:+)
  end

  def initialize(data, constant_pool)
    access_flags, name_index, descriptor_index, attributes_count = data.unpack('n4')
    @struct_members = [
      Field.new('access_flags', 2, access_flags),
      Field.new('name_index', 2, name_index),
      Field.new('descriptor_index', 2, descriptor_index),
      Field.new('attributes_count', 2, attributes_count)
    ]
    data = data[8..-1]

    @attributes = []
    attributes_count.times do
      attribute_info = AttributeInfo.new(data, constant_pool)
      @attributes << attribute_info

      data = data[attribute_info.struct_size..-1]
    end
  end
end
