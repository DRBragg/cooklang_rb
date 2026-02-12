# frozen_string_literal: true

module WithUnits
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def clean_units(units)
      units&.strip || ""
    end
  end

  module ClassMethods
    def multi_word_pattern
      /#{tag}#{TagParser::MULTI_NAME}?{#{TagParser::QUANTITY}%?#{TagParser::UNITS}}/
    end
  end
end
