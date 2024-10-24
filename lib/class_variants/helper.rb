module ClassVariants
  module Helper
    module ClassMethods
      def class_variants(...)
        @_class_variants_instance = ClassVariants.build(...)
      end

      def _class_variants_instance
        @_class_variants_instance
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def class_variants(...)
      raise "You must configure class_variants in class definition" unless self.class._class_variants_instance

      self.class._class_variants_instance.render(...)
    end
  end
end
