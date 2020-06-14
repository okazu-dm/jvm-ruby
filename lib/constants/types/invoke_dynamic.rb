require_relative '../constant_info'

class InvokeDynamicInfo < ConstantInfo
  u1 'tag'
  u2 'bootstrap_method_attr_index'
  u2 'name_and_type_index'
end
