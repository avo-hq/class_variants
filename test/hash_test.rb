require "test_helper"

class HashTest < Minitest::Test
  def setup
    @cv = ClassVariants.build(
      base: "text-white py-1 px-3 rounded-full",
      variants: {
        color: {
          primary: "bg-blue-500",
          secondary: "bg-purple-500",
          success: "bg-green-500"
        },
        size: {
          sm: "py-1 px-3 text-xs",
          md: "py-1.5 px-4 text-sm",
          lg: "py-2 px-6 text-md"
        },
        disabled: "opacity-50 bg-gray-500",
        "!visible": "hidden"
      },
      compound_variants: [
        {color: :success, disabled: true, class: "bg-green-100 text-green-700"}
      ],
      defaults: {
        size: :sm
      }
    )
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
end
