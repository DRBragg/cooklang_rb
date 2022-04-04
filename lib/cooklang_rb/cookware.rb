require_relative "tag_parser"
require_relative "steppable"
require_relative "quantity_resolver"

module CooklangRb
  class Cookware
    include TagParser
    include Steppable
    include QuantityResolver

    attr_reader :name, :quantity

    def self.tag
      COOKWARE_TAG
    end

    def initialize(name:, quantity:  1)
      @name = name.delete_prefix(tag).chomp
      @quantity = resolve_quantity(quantity, default: 1)
    end
  end
end
