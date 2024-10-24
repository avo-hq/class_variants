require "test_helper"

class HelperTest < Minitest::Test
  class DemoClass
    include ClassVariants::Helper

    class_variants base: "rounded border"
  end

  def test_call_from_instance
    assert_equal "rounded border", DemoClass.new.class_variants
  end
end
