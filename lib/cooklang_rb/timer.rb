require_relative "tag_parser"
require_relative "steppable"
require_relative "with_units"

module CooklangRb
  class Timer
    include TagParser
    include Steppable
    include QuantityResolver
    include WithUnits

    attr_reader :name, :quantity, :units

    def self.tag
      TIMER_TAG
    end

    def initialize(name:, quantity: "", units: "")
      @name = name ? name.delete_prefix(tag).chomp : ""
      @quantity = resolve_quantity(quantity)
      @units = clean_units(units)
    end
  end
end
