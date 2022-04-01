require "strscan"

require_relative "ingredient"
require_relative "cookware"
require_relative "timer"
require_relative "text"
require_relative "metadata"

module CooklangRb
  class Recipe
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

      until @buffer.eos?
        parse_data
      end
    end

    def remove_comments
      @source.gsub!(/\[-.*-\]/, "")
      @source.gsub!(/--.*\n/, "\n")
    end

    def parse_data
      if @buffer.peek(1) == "\n"
        @buffer.getch
        return
      end

      @steps << build_step
    end

    def build_step
      step = []

      until @buffer.peek(1) == "\n" || @buffer.eos?
        step << take_step
      end

      step
    end

    def take_step
      case @buffer.peek(1)
      when "@"
        Ingredient.parse_from(@buffer).to_step
      when "#"
        Cookware.parse_from(@buffer).to_step
      when "~"
        Timer.parse_from(@buffer).to_step
      else
        Text.parse_from(@buffer).to_step
      end
    end

    def gather_metadata
      @metadata = Metadata.new(@buffer).parse
    end
  end
end
