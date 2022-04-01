require_relative "steppable"

module CooklangRb
  class Text
    include Steppable

    attr_reader :value

    TAGS = /[@#~]|\n/

    def self.parse_from(buffer)
      text = buffer.scan_until TAGS
      text = text&.sub(TAGS, "") || buffer.rest
      buffer.pos = buffer.pos - 1 unless buffer.eos?
      new text.chomp
    end

    def initialize(value)
      @value = value
    end
  end
end
