require_relative '../constant_info'

class MethodrefInfo < ConstantInfo
  u1 'tag'
  u2 'class_index'
  u2 'name_and_type_index'
end