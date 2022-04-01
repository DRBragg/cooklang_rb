require_relative "tag_parser"
require_relative "steppable"

module CooklangRb
  class Ingredient
    include TagParser
    include Steppable

    attr_reader :name, :quantity, :units

    def self.tag
      INGREDIENT_TAG
    end

    def initialize(name:, quantity: "some", units: "")
      @name = name.delete_prefix(tag).chomp
      @quantity = normalize quantity
      @units = units&.strip || ""
    end

    private

    def normalize(value)
      return "some" if value.nil? || value.strip.empty?

      value.strip! if value.respond_to?(:strip!)

      if value.include?(".")
        value.to_f
      elsif value.include?("/") && value[0] != "0"
        value.gsub(/\s/, "").to_r.to_f
      elsif value.match? /^[0-9]+$/
        value.to_i
      else
        value
      end
    end
  end
end
