require "class_variants/version"
require "class_variants/action_view/helpers"
require "class_variants/instance"
require "class_variants/railtie" if defined?(Rails)

module ClassVariants
  Configuration = Struct.new(:tw_merge, :tw_merge_config, keyword_init: true)

  @mutex = Mutex.new

  class << self
    def configuration
      @configuration ||= Configuration.new(tw_merge: false, tw_merge_config: {})
    end

    def configure(&block)
      yield(configuration)
    end

    def build(classes, **args)
      Instance.new classes, **args
    end

    def tailwind_merge
      @mutex.synchronize do
        @tailwind_merge ||= begin
          require "tailwind_merge"
          TailwindMerge::Merger.new(config: configuration.tw_merge_config)
        end
      end
    end
  end
end
