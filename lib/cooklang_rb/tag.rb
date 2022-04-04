require_relative "tag_parser"
require_relative "steppable"
require_relative "quantity_resolver"

module CooklangRb
  class Tag
    include TagParser
    include Steppable
    include QuantityResolver

    def clean_name(name)
      name.delete_prefix(tag).chomp
    end
  end
end
