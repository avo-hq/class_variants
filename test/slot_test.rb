require "test_helper"

class SlotTest < Minitest::Test
  def setup
    @cv = ClassVariants.build do
      base do
        slot :root, class: "rounded py-3 px-5 mb-4"
        slot :title, class: "font-bold mb-1"
      end

      variant variant: :outlined do
        slot :root, class: "border"
      end

      variant variant: :outlined, severity: :error do
        slot :root, class: "border-red-700 dark:border-red-500"
        slot :title, class: "text-red-700 dark:text-red-500"
        slot :message, class: "text-red-600 dark:text-red-500"
      end

      variant variant: :outlined, severity: :success do
        slot :root, class: "border-green-700 dark:border-green-500"
        slot :title, class: "text-green-700 dark:text-green-500"
        slot :message, class: "text-green-600 dark:text-green-500"
      end

      variant variant: :filled, severity: :error do
        slot :root, class: "bg-red-100 dark:bg-red-800"
        slot :title, class: "text-red-900 dark:text-red-50"
        slot :message, class: "text-red-700 dark:text-red-200"
      end

      variant variant: :filled, severity: :success do
        slot :root, class: "bg-green-100 dark:bg-green-800"
        slot :title, class: "text-green-900 dark:text-green-50"
        slot :message, class: "text-green-700 dark:text-green-200"
      end

      defaults variant: :filled, severity: :success
    end
  end

  def test_render_default_slot
    assert_equal "", @cv.render
  end

  def test_render_nonexistent_slot
    assert_equal "", @cv.render(:nonexistent)
  end

  def test_render_slot_with_defaults
    assert_equal "rounded py-3 px-5 mb-4 bg-green-100 dark:bg-green-800", @cv.render(:root)
  end

  def test_render_slot_with_variant
    assert_equal "rounded py-3 px-5 mb-4 border border-green-700 dark:border-green-500", @cv.render(:root, variant: :outlined)
  end

  def test_render_slot_without_base
    assert_equal "text-green-700 dark:text-green-200", @cv.render(:message)
  end

  def test_render_slot_with_unused_variant
    assert_equal(
      "rounded py-3 px-5 mb-4 border border-green-700 dark:border-green-500",
      @cv.render(:root, variant: :outlined, type: :button)
    )
  end
end
