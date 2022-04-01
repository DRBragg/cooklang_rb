require_relative "tag_parser"
require_relative "steppable"

module CooklangRb
  class Cookware
    include TagParser
    include Steppable

    attr_reader :name, :quantity

    def self.tag
      COOKWARE_TAG
    end

    def self.multi_word_pattern
      /#{tag}#{MULTI_NAME}{#{QUANTITY}}/
    end

    def initialize(name:, quantity:  1)
      @name = name.delete_prefix(tag).chomp
      @quantity = normalize quantity
    end

    private

    def normalize(value)
      return value if value.is_a? Numeric

      value.strip! if value.respond_to?(:strip!)

      if value.include?(".")
        value.to_f
      elsif value.include?("/") && value[0] != "0"
        value.gsub(/\s/, "").to_r.to_f
      elsif value.match? /^[0-9]+$/
        value.to_i
      else
        value.empty? ? 1 : value
      end
    end
  end
end
