# frozen_string_literal: true

require_relative "ingredient"
require_relative "cookware"
require_relative "timer"
require_relative "text"
require_relative "buffer_utils"

module CooklangRb
  class Step
    include BufferUtils

    TAG_MAP = {
      "@" => Ingredient,
      "#" => Cookware,
      "~" => Timer
    }.freeze

    def initialize(buffer)
      @buffer = buffer
      @content = []
    end

    def build
      until end_of_step?
        @content << take_step
      end

      @content
    end

    private

    def take_step
      next_step.parse_from(@buffer).to_step
    end

    def next_step
      TAG_MAP[@buffer.peek(1)] || Text
    end

    def end_of_step?
      end_of_line? || end_of_buffer?
    end
  end
end
