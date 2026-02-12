# frozen_string_literal: true

require_relative "steppable"

module CooklangRb
  class Text
    include Steppable

    attr_reader :value

    TAG_BOUNDARY = /[@#~](?=[^\p{Zs}\s])|\n/

    def self.parse_from(buffer)
      text = buffer.scan_until TAG_BOUNDARY

      if text
        text = text.chop
        buffer.pos -= 1 unless buffer.eos?
      else
        text = buffer.rest
        buffer.terminate
      end

      new text.chomp
    end

    def initialize(value)
      @value = value
    end
  end
end
