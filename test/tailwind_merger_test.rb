require "test_helper"

class TailwindMergerTest < Minitest::Test
  def teardown
    ClassVariants.configure do |config|
      config.tw_merge = false
    end
  end

  def test_without_tw_merge
    assert_equal "border rounded px-2 py-1 p-5", ClassVariants.build("border rounded px-2 py-1 p-5").render
  end

  def test_with_tw_merge
    ClassVariants.configure do |config|
      config.tw_merge = true
    end

    assert_equal "border rounded p-5", ClassVariants.build("border rounded px-2 py-1 p-5").render
  end
end
