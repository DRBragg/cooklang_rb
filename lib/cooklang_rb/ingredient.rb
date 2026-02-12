# frozen_string_literal: true

require_relative "tag"
require_relative "with_units"

module CooklangRb
  class Ingredient < Tag
    include WithUnits

    attr_reader :name, :quantity, :units

    def self.tag
      INGREDIENT_TAG
    end

    def initialize(name:, quantity: "some", units: "")
      @name = clean_name(name)
      @quantity = resolve_quantity(quantity, default: "some")
      @units = clean_units(units)
    end
  end
end
