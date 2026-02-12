# frozen_string_literal: true

module Steppable
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def to_step
      data = {"type" => type}
      attributes.each do |key|
        data[key.to_s] = send key
      end
      data
    end

    def type
      self.class.name.to_s.split("::").last.downcase
    end

    def attributes
      self.class.attributes
    end
  end

  module ClassMethods
    def attr_reader(*vars)
      @attributes ||= []
      @attributes.concat vars
      super
    end

    def attributes
      @attributes
    end
  end
end
