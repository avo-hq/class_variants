require "test_helper"

class ClassVariantsTest < Minitest::Test
  def setup
    @cv = ClassVariants.build(
      "rounded border",
      variants: {
        size: {
          sm: "text-sm",
          md: "text-md"
        },
        color: {
          red: "text-red",
          green: "text-green"
        },
        visible: "inline-block",
        "!visible": "hidden"
      },
      defaults: {
        size: :md
      }
    )
  end

  def test_base_with_defaults
    assert_equal "rounded border text-md", @cv.render
  end

  def test_base_with_defaults_overwrite
    assert_equal "rounded border text-sm", @cv.render(size: :sm)
  end

  def test_base_with_defaults_overwrite_and_add
    assert_equal "rounded border text-sm text-green", @cv.render(size: :sm, color: :green)
  end

  def test_boolean_variants
    assert_equal "rounded border text-md inline-block", @cv.render(visible: true)
    assert_equal "rounded border text-md hidden", @cv.render(visible: false)
  end
end
