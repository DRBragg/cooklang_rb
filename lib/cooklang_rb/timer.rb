require_relative "tag_parser"
require_relative "steppable"

module CooklangRb
  class Timer
    include TagParser
    include Steppable
    include QuantityResolver

    attr_reader :name, :quantity, :units

    def self.tag
      TIMER_TAG
    end

    def initialize(name:, quantity: "", units: "")
      @name = name ? name.delete_prefix(tag).chomp : ""
      @quantity = resolve_quantity(quantity)
      @units = units&.strip || ""
    end
  end
end
