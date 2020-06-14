require_relative '../constant_info'

class MethodTypeInfo < ConstantInfo
  u1 'tag'
  u2 'descriptor_index'
end
