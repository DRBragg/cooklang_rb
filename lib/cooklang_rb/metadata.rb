module CooklangRb
  class Metadata
    TAG = ">>".freeze
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
      data = PATTERN.match(@buffer.scan(PATTERN)).named_captures
      @metadata[data["key"].strip] = data["value"]
    end
  end
end
