require_relative '../constant_info'

class FieldrefInfo < ConstantInfo
  u1 'tag'
  u2 'class_index'
  u2 'name_and_type_index'
end