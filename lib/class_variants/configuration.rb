# frozen_string_literal: true

module ClassVariants
  class Configuration
    def process_classes_with(&block)
      if block_given?
        @process_classes_with = block
      else
        @process_classes_with
      end
    end
  end
end
