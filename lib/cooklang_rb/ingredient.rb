require_relative "tag_parser"
require_relative "steppable"
require_relative "quantity_resolver"

module CooklangRb
  class Ingredient
    include TagParser
    include Steppable
    include QuantityResolver

    attr_reader :name, :quantity, :units

    def self.tag
      INGREDIENT_TAG
    end

    def initialize(name:, quantity: "some", units: "")
      @name = name.delete_prefix(tag).chomp
      @quantity = resolve_quantity(quantity, default: "some")
      @units = units&.strip || ""
    end
  end
end
