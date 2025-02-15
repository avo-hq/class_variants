# frozen_string_literal: true

module ClassVariants
  class Instance
    def initialize(...)
      @bases = []
      @variants = []
      @defaults = {}

      merge(...)
    end

    def dup
      self.class.new.tap do |copy|
        copy.instance_variable_set(:@bases, @bases.dup)
        copy.instance_variable_set(:@variants, @variants.dup)
        copy.instance_variable_set(:@defaults, @defaults.dup)
      end
    end

    def merge(**options, &block)
      raise ArgumentError, "Use of hash config and code block is not supported" if !options.empty? && block_given?

      (base = options.fetch(:base, nil)) && @bases << {class: base, slot: :default}
      @variants += [
        expand_variants(options.fetch(:variants, {})),
        expand_compound_variants(options.fetch(:compound_variants, []))
      ].inject(:+)
      @defaults.merge!(options.fetch(:defaults, {}))

      instance_eval(&block) if block_given?

      self
    end

    def render(slot = :default, **overrides)
      classes = overrides.delete(:class)
      result = []

      # Start with our default classes
      @bases.each do |base|
        result << base[:class] if base[:slot] == slot
      end

      # Then merge the passed in overrides on top of the defaults
      criteria = @defaults.merge(overrides)

      @variants.each do |candidate|
        next unless candidate[:slot] == slot

        if (candidate.keys - [:class, :slot]).all? { |key| criteria[key] == candidate[key] }
          result << candidate[:class]
        end
      end

      # add the passed in classes to the result
      result << classes

      # Compact out any nil values we may have dug up
      result.compact!

      # Return the final token list
      with_classess_processor(result.join(" "))
    end

    private

    def base(klass = nil, &block)
      raise ArgumentError, "Use of positional argument and code block is not supported" if klass && block_given?

      if block_given?
        with_slots(&block).each do |slot|
          @bases << slot
        end
      else
        @bases << {slot: :default, class: klass}
      end
    end

    def variant(**options, &block)
      raise ArgumentError, "Use of class option and code block is not supported" if options.key?(:class) && block_given?

      if block_given?
        with_slots(&block).each do |slot|
          @variants << options.merge(slot)
        end
      else
        @variants << options.merge(slot: :default)
      end
    end

    def defaults(**options)
      @defaults = options
    end

    def slot(name = :default, **options)
      raise ArgumentError, "class option is required" unless options.key?(:class)

      @slots << options.merge(slot: name)
    end

    def with_slots
      @slots = []
      yield
      @slots
    end

    def expand_variants(variants)
      variants.flat_map do |property, values|
        case values
        when String
          {property.to_s.delete_prefix("!").to_sym => !property.to_s.start_with?("!"), :class => values, :slot => :default}
        else
          values.map do |key, value|
            {property => key, :class => value, :slot => :default}
          end
        end
      end
    end

    def expand_compound_variants(compound_variants)
      compound_variants.map do |compound_variant|
        compound_variant.merge(slot: :default)
      end
    end

    def with_classess_processor(classes)
      if ClassVariants.configuration.process_classes_with.respond_to?(:call)
        ClassVariants.configuration.process_classes_with.call(classes)
      else
        classes
      end
    end
  end
end
