require "test_helper"

class MultipleValuesTest < Minitest::Test
  def setup
    @cv = ClassVariants.build do
      variant color: %i[primary secondary], class: "shadow-sm"
      variant color: :primary, class: "bg-blue-500"
      variant color: :secondary, class: "bg-purple-500"
      variant color: :success, class: "bg-green-500"
    end
  end

  def test_render
    assert_equal "shadow-sm bg-blue-500", @cv.render(color: :primary)
    assert_equal "shadow-sm bg-purple-500", @cv.render(color: :secondary)
    assert_equal "bg-green-500", @cv.render(color: :success)
  end
end
