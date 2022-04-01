require_relative "tag_parser"
require_relative "steppable"

module CooklangRb
  class Timer
    include TagParser
    include Steppable

    attr_reader :name, :quantity, :units

    def self.tag
      TIMER_TAG
    end

    def initialize(name:, quantity: "some", units: "")
      @name = name ? name.delete_prefix(tag).chomp : ""
      @quantity = normalize quantity
      @units = units&.strip || ""
    end

    private

    def normalize(value)
      return "" if value.nil?

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
