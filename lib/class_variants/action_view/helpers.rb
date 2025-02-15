# frozen_string_literal: true

module ClassVariants
  module ActionView
    module Helpers
      def class_variants(...)
        ClassVariants::Instance.new(...)
      end
    end
  end
end
