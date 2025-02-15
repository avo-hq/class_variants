# frozen_string_literal: true

module ClassVariants
  module Helper
    module ClassMethods
      def class_variants(...)
        singleton_class.instance_variable_get(:@_class_variants_instance).merge(...)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
      base.singleton_class.instance_variable_set(:@_class_variants_instance, ClassVariants::Instance.new)
      base.define_singleton_method(:inherited) do |subclass|
        subclass.singleton_class.instance_variable_set(
          :@_class_variants_instance, base.singleton_class.instance_variable_get(:@_class_variants_instance).dup
        )
      end
    end

    def class_variants(...)
      self.class.singleton_class.instance_variable_get(:@_class_variants_instance).render(...)
    end
  end
end
