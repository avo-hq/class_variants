require "test_helper"

class HelperTest < Minitest::Test
  class BaseClass
  end

  class DemoClass < BaseClass
    include ClassVariants::Helper

    class_variants base: "rounded border"
  end

  class SubClass < DemoClass
    class_variants base: "bg-black"
  end

  def test_inherited
    mock = Minitest::Mock.new
    mock.expect(:call, nil, [Class])

    BaseClass.stub(:inherited, mock) do
      Class.new(DemoClass)
    end

    mock.verify
  end

  def test_call_from_instance
    assert_equal "rounded border", DemoClass.new.class_variants
  end

  def test_call_from_subclass
    assert_equal "rounded border bg-black", SubClass.new.class_variants
  end
end
