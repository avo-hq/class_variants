require "test_helper"

class DefinitionsTest < Minitest::Test
  def setup
    ClassVariants.define :button do
      variant color: :primary, class: "bg-orange-500"
    end

    ClassVariants.define :link do
      variant color: :primary, class: "bg-blue-500"
    end
  end

  def teardown
    ClassVariants.instance_variable_set(:@definitions, nil)
  end

  def test_definitions
    assert_equal "bg-orange-500", ClassVariants.for(:button).render(color: :primary)
    assert_equal "bg-blue-500", ClassVariants.for(:link).render(color: :primary)
  end
end
