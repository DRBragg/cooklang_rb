require_relative "tag"

module CooklangRb
  class Cookware < Tag
    attr_reader :name, :quantity

    def self.tag
      COOKWARE_TAG
    end

    def initialize(name:, quantity:  1)
      @name = clean_name(name)
      @quantity = resolve_quantity(quantity, default: 1)
    end
  end
end
