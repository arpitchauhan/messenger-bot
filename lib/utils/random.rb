module Utils
  class Random

    def self.small_natural_number(format = :string)
      format_number(rand(10000), format)
    end

    def self.large_natural_number(format = :string)
      format_number(rand.to_s[2..10], format)
    end

    def self.time(constraint = nil)
      Time.zone.at(timestamp(constraint, :integer) / 1000)
    end

    def self.timestamp(constraint = nil, format = :string)
      current_timestamp = Time.current.to_i * 1000
      case constraint
      when :before_now
        format_number((rand(0.9..0.99) * (current_timestamp)).to_i, format)
      when nil
        format_number((rand(0.9..1.1) * (current_timestamp)).to_i, format)
      else
        raise "Constraint #{constraint} not supported"
      end
    end

    private_class_method

    def self.format_number(number, type)
      case type
      when :string
        number.to_s
      when :integer
        number.to_i
      when :float
        number.to_f
      when :bigdecimal
        number.to_d
      else
        raise "Format #{type} not supported"
      end
    end
  end
end
