require "test_helper"

class MergeTest < Minitest::Test
  def test_hash_merge
    cv = ClassVariants.build(
      base: "rounded",
      variants: {
        color: {
          primary: "bg-blue-500",
          secondary: "bg-purple-500",
          success: "bg-green-500"
        }
      },
      default: {
        color: :primary
      }
    )
    cv.merge(
      base: "border",
      variants: {
        color: {
          primary: "bg-blue-700",
          secondary: "bg-purple-700"
        }
      },
      defaults: {
        color: :secondary
      }
    )

    assert_equal "rounded border bg-purple-500 bg-purple-700", cv.render
  end

  def test_block_merge
    cv = ClassVariants.build do
      base do
        slot :root, class: "rounded"
        slot :title, class: "font-bold"
      end

      variant variant: :outlined do
        slot :root, class: "border-red-700"
        slot :title, class: "text-red-700"
      end

      variant variant: :filled do
        slot :root, class: "bg-red-100"
        slot :title, class: "text-red-900"
      end

      defaults variant: :outlined
    end

    cv.merge do
      base do
        slot :root, class: "mb-4"
        slot :title, class: "mb-1"
      end

      variant variant: :filled do
        slot :root, class: "dark:bg-red-800"
        slot :title, class: "dark:text-red-50"
      end

      defaults variant: :filled
    end

    assert_equal "rounded mb-4 bg-red-100 dark:bg-red-800", cv.render(:root)
    assert_equal "font-bold mb-1 text-red-900 dark:text-red-50", cv.render(:title)
  end
end
