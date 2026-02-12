# frozen_string_literal: true

require_relative "tag"
require_relative "with_units"

module CooklangRb
  class Cookware < Tag
    include WithUnits

    attr_reader :name, :quantity, :units

    def self.tag
      COOKWARE_TAG
    end

    def initialize(name:, quantity: 1, units: "")
      @name = clean_name(name)
      @quantity = resolve_quantity(quantity, default: 1)
      @units = clean_units(units)
    end
  end
end
