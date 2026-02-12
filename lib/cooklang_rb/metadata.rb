# frozen_string_literal: true

module CooklangRb
  class Metadata
    TAG = ">>"
    PATTERN = /^#{TAG}\s*(?<key>.+?):\s*(?<value>.+)\n/

    def initialize(buffer)
      @buffer = buffer
      @metadata = {}
    end

    def parse
      return @metadata unless @buffer.match? PATTERN

      until @buffer.peek(2) != TAG
        add_metadata
      end

      @metadata
    end

    private

    def add_metadata
      @buffer.scan(PATTERN)
      key, value = @buffer.captures.map(&:strip)
      @metadata[key] = value
    end
  end
end
