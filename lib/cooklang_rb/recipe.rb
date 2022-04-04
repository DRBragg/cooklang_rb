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
      @source = source
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
      remove_comments

      @buffer = StringScanner.new(@source)

      gather_metadata

      until end_of_buffer?
        parse_data
      end
    end

    def remove_comments
      @source.gsub!(/\[-.*-\]/, "")
      @source.gsub!(/--.*\n/, "\n")
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
      @metadata = Metadata.new(@buffer).parse
    end
  end
end
