require "test_helper"

class BlockTest < Minitest::Test
  def setup
    @cv = ClassVariants.build do
      base "text-white py-1 px-3 rounded-full"

      variant color: :primary, class: "bg-blue-500"
      variant color: :secondary, class: "bg-purple-500"
      variant color: :success, class: "bg-green-500"

      variant size: :sm, class: "py-1 px-3 text-xs"
      variant size: :md, class: "py-1.5 px-4 text-sm"
      variant size: :lg, class: "py-2 px-6 text-md"

      variant disabled: true, class: "opacity-50 bg-gray-500"
      variant visible: false, class: "hidden"

      variant color: :success, disabled: true, class: "bg-green-100 text-green-700"

      defaults size: :sm
    end
  end

  def test_render_with_defaults
    assert_equal "text-white py-1 px-3 rounded-full py-1 px-3 text-xs", @cv.render
  end

  def test_render_with_size
    assert_equal "text-white py-1 px-3 rounded-full py-1.5 px-4 text-sm", @cv.render(size: :md)
  end

  def test_render_with_size_and_color
    assert_equal(
      "text-white py-1 px-3 rounded-full bg-green-500 py-1 px-3 text-xs",
      @cv.render(size: :sm, color: :success)
    )
  end

  def test_boolean_variants
    assert_equal "text-white py-1 px-3 rounded-full py-1 px-3 text-xs", @cv.render(visible: true)
    assert_equal "text-white py-1 px-3 rounded-full py-1 px-3 text-xs hidden", @cv.render(visible: false)
  end

  def test_compound_variants
    assert_equal(
      "text-white py-1 px-3 rounded-full bg-green-500 py-1 px-3 text-xs opacity-50 bg-gray-500 bg-green-100 text-green-700",
      @cv.render(color: :success, disabled: true)
    )
  end

  def test_additional_classes
    assert_equal "text-white py-1 px-3 rounded-full py-1 px-3 text-xs text-black", @cv.render(class: "text-black")
  end
end
