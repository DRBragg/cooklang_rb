# frozen_string_literal: true

require "test_helper"
require "yaml"


class CooklangRbTest < Minitest::Test
  tests = YAML.load(File.read("test/canonical.yml"))["tests"]

  def test_that_it_has_a_version_number
    refute_nil ::CooklangRb::VERSION
  end

  tests.each do |test|
    define_method("test_#{test.first}") do
      data = test.last
      recipe = ::CooklangRb::Recipe.new(data["source"])
      output = recipe.data
      assert_equal data["result"]["steps"], output["steps"]
      assert_equal data["result"]["metadata"], output["metadata"]
    end
  end
end
