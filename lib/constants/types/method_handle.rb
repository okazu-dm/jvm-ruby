require_relative '../constant_info'

class MethodHandleInfo < ConstantInfo
  u1 'tag'
  u1 'reference_kind'
  u2 'reference_index'
end
