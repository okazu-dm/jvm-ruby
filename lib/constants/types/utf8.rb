require_relative '../constant_info'

class UTF8Info < ConstantInfo
  u1 'tag'
  u2 'length'
  var 'bytes' # bytes[length]

  def initialize(data)
    tag, bytes_length = data.unpack('Cn')
    @struct_members = [
      Field.new('tag', 1, tag),
      Field.new('length', 2, bytes_length)
    ]

    bytes_value = data[3..-1].unpack("C#{bytes_length}").map(&:chr).join('')
    @struct_members << Field.new('bytes', bytes_length, bytes_value)
  end

  def value
    @struct_members[-1].value
  end

end