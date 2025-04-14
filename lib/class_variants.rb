# frozen_string_literal: true

require "class_variants/version"
require "class_variants/action_view/helpers"
require "class_variants/configuration"
require "class_variants/instance"
require "class_variants/helper"
require "class_variants/railtie" if defined?(Rails)

module ClassVariants
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure(&block)
      yield(configuration)
    end

    def build(...)
      Instance.new(...)
    end

    def definitions
      @definitions ||= {}
    end

    def define(name, ...)
      definitions[name.to_sym] = Instance.new(...)
    end

    def for(name)
      definitions[name.to_sym]
    end
  end
end
