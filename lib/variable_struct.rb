class VariableStruct
  attr_reader :struct_members
  FieldDefinition = Struct.new('FieldDefinition', :name, :size)
  Field = Struct.new('Field', :name, :size, :value)

  def definitions
    self.class.definitions
  end

  def struct_size
    @struct_members.map(&:size).inject(:+)
  end

  def initialize(data)
    unpack_exp = ''
    definitions.each do |definition|
      size = definition.size
      case size
      when 1
        unpack_exp += 'C'
      when 2
        unpack_exp += 'n'
      when 4
        unpack_exp += 'N'
      end
    end
    @struct_members = data.unpack(unpack_exp).map.with_index do |raw_value, idx|
      definition = definitions[idx]
      Field.new(definition.name, definition.size, raw_value)
    end
  end

  class << self
    attr_reader :definitions
    def define_field(name, size)
      @definitions ||= []
      @definitions << FieldDefinition.new(name, size)
    end

    def u1(name); define_field(name, 1); end
    def u2(name); define_field(name, 2); end
    def u4(name); define_field(name, 4); end

    def var(name)
      define_field(name, -255 * 255)
    end
  end
end
