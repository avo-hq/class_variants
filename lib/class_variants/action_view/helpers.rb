module ClassVariants
  module ActionView
    module Helpers
      def class_variants(classes, **args)
        ClassVariants::Instance.new classes, **args
      end
    end
  end
end