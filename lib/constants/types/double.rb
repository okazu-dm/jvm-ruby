require_relative '../constant_info'

class DoubleInfo < ConstantInfo
  u1 'tag'
  u4 'high_bytes'
  u4 'low_bytes'
end
