# frozen_string_literal: true

module TagParser
  NAME = "(?<name>[^\\t\\n\\r\\f\\v\\p{Zs}\\p{P}]+)"
  MULTI_NAME = "(?<name>[^@#~{]+)"
  QUANTITY = "(?<quantity>[^%}]*)?"
  UNITS = "(?<units>[^}]+)?"
  TIMER_TAG = "~"
  INGREDIENT_TAG = "@"
  COOKWARE_TAG = "#"

  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def tag
      self.class.tag
    end
  end

  module ClassMethods
    def parse_from(buffer)
      if buffer.match? multi_word_pattern
        new(**multi_word_pattern.match(buffer.scan(multi_word_pattern)).named_captures.transform_keys(&:to_sym))
      else
        new(name: buffer.scan(single_word_pattern))
      end
    end

    def multi_word_pattern
      /#{tag}#{MULTI_NAME}{#{QUANTITY}}/
    end

    def single_word_pattern
      /#{tag}#{NAME}/
    end
  end
end
