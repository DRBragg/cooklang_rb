# frozen_string_literal: true

require "strscan"

require_relative "metadata"
require_relative "step"
require_relative "buffer_utils"

module CooklangRb
  class Recipe
    include BufferUtils

    attr_reader :metadata, :steps

    def self.from(source)
      new(source).data
    end

    def initialize(source)
      @source = source.dup
      @steps = []
      @metadata = {}
      parse
    end

    def data
      {
        "metadata" => @metadata,
        "steps" => @steps
      }
    end

    private

    def parse
      gather_metadata
      remove_comments

      @buffer = StringScanner.new(@source)

      until end_of_buffer?
        parse_data
      end
    end

    def remove_comments
      @source.gsub!(/\[-.*-\]/, "")
      @source.gsub!(/^[[:blank:]]*(?<!-)--(?!-).*\n/, "")
      @source.gsub!(/(?<!-)--(?!-).*\n/, " ")
    end

    def parse_data
      if end_of_line?
        @buffer.getch
        return
      end

      @steps << build_step
    end

    def build_step
      Step.new(@buffer).build
    end

    def gather_metadata
      @metadata, @source = Metadata.new(@source).parse
    end
  end
end
