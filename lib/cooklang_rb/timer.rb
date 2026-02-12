# frozen_string_literal: true

require_relative "tag"
require_relative "with_units"

module CooklangRb
  class Timer < Tag
    include WithUnits

    attr_reader :name, :quantity, :units

    def self.tag
      TIMER_TAG
    end

    def initialize(name:, quantity: "", units: "")
      @name = name ? clean_name(name) : ""
      @quantity = resolve_quantity(quantity)
      @units = clean_units(units)
    end
  end
end
