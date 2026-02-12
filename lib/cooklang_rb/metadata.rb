# frozen_string_literal: true

module CooklangRb
  class Metadata
    DELIMITER = "---"
    ENTRY_PATTERN = /^(?<key>.+?):\s*(?<value>.+)$/

    def initialize(source)
      @source = source
      @metadata = {}
    end

    def parse
      if valid_metadata_block?
        extract_metadata
        strip_metadata_block
      else
        collapse_invalid_delimiters
      end

      [@metadata, @source]
    end

    private

    def valid_metadata_block?
      @source.start_with?("#{DELIMITER}\n")
    end

    def extract_metadata
      lines = metadata_lines
      lines.each do |line|
        match = line.match(ENTRY_PATTERN)
        next unless match

        @metadata[match[:key].strip] = match[:value].strip
      end
    end

    def metadata_lines
      closing = @source.index("\n#{DELIMITER}", DELIMITER.length)
      return [] unless closing

      block = @source[DELIMITER.length + 1...closing]
      block.split("\n")
    end

    def strip_metadata_block
      closing = @source.index("\n#{DELIMITER}", DELIMITER.length)
      return unless closing

      end_pos = closing + 1 + DELIMITER.length
      end_pos += 1 if @source[end_pos] == "\n"
      @source = @source[end_pos..]
    end

    def collapse_invalid_delimiters
      @source = @source.gsub(/---\n(.*?\n)?---(?:\n|\z)/m) do |match|
        match.tr("\n", " ").rstrip
      end
    end
  end
end
