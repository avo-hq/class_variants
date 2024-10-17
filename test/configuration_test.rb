require "test_helper"

class ConfigurationTest < Minitest::Test
  def teardown
    ClassVariants.configure do |config|
      config.tw_merge = false
    end
  end

  def test_configuration_tw_merge_default
    refute ClassVariants.configuration.tw_merge
  end

  def test_configuration_tw_merge_config_default
    assert_empty ClassVariants.configuration.tw_merge_config
  end

  def test_configure
    ClassVariants.configure do |config|
      config.tw_merge = true
    end

    assert ClassVariants.configuration.tw_merge
  end
end
