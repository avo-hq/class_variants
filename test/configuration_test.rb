require "test_helper"

class ConfigurationTest < Minitest::Test
  def teardown
    ClassVariants.configuration.instance_variable_set(:@process_classes_with, nil)
  end

  def test_configuration_process_classes_with_default
    refute ClassVariants.configuration.process_classes_with
  end

  def test_configure
    ClassVariants.configure do |config|
      config.process_classes_with { |classes| classes }
    end

    assert_respond_to ClassVariants.configuration.process_classes_with, :call
  end
end
