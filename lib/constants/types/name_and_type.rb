require_relative '../constant_info'

class NameAndTypeInfo < ConstantInfo
  u1 'tag'
  u2 'name_index'
  u2 'descriptor_index'
end
