require "class_variants/version"
require "class_variants/action_view/helpers"
require "class_variants/instance"
require "class_variants/railtie" if defined?(Rails)

module ClassVariants
  class << self
    def build(classes, **args)
      Instance.new classes, **args
    end
  end
end
