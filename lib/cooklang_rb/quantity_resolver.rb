# frozen_string_literal: true

module QuantityResolver
  def resolve_quantity(quantity, default: "")
    return default if quantity.nil?
    return quantity if quantity.is_a? Numeric

    quantity = quantity.strip if quantity.respond_to?(:strip)

    if quantity.include?(".")
      quantity.to_f
    elsif quantity.include?("/") && quantity[0] != "0"
      quantity.gsub(/\s/, "").to_r.to_f
    elsif quantity.match?(/^[0-9]+$/)
      quantity.to_i
    else
      quantity.empty? ? default : quantity
    end
  end
end
