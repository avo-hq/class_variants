require "test_helper"

class ProcessClassesWithTest < Minitest::Test
  def teardown
    ClassVariants.configuration.instance_variable_set(:@process_classes_with, nil)
  end

  def test_without_classes_processor
    assert_equal "border rounded px-2 py-1 p-5", ClassVariants.build(base: "border rounded px-2 py-1 p-5").render
  end

  def test_with_classes_processor
    ClassVariants.configure do |config|
      config.process_classes_with do |classes|
        merger.merge(classes)
      end
    end

    assert_equal "border rounded p-5", ClassVariants.build(base: "border rounded px-2 py-1 p-5").render
  end

  private

  def merger
    require "tailwind_merge"
    TailwindMerge::Merger.new
  rescue LoadError
    Class.new do
      def merge(classes)
        classes.gsub("px-2 py-1 ", "")
      end
    end.new
  end
end
