module ClassVariants
  class Instance
    def initialize(**options, &block)
      raise ArgumentError, "Use of hash config and code block is not supported" if !options.empty? && block_given?

      @base = options.empty? ? {} : {default: options.fetch(:base, nil)}
      @variants = expand_variants(options.fetch(:variants, {})) + expand_compound_variants(options.fetch(:compound_variants, []))
      @defaults = options.fetch(:defaults, {})

      instance_eval(&block) if block_given?
    end

    def render(slot = :default, **overrides)
      # Start with our default classes
      result = [@base[slot]]

      # Then merge the passed in overrides on top of the defaults
      criteria = @defaults.merge(overrides)

      @variants.each do |candidate|
        next unless candidate[:slot] == slot

        if (candidate.keys - [:class, :slot]).all? { |key| criteria[key] == candidate[key] }
          result << candidate[:class]
        end
      end

      # Compact out any nil values we may have dug up
      result.compact!

      # Return the final token list
      result.join " "
    end

    private

    def base(klass = nil, &block)
      raise ArgumentError, "Use of positional argument and code block is not supported" if klass && block_given?

      if block_given?
        with_slots(&block).each do |slot|
          @base[slot[:slot]] = slot[:class]
        end
      else
        @base[:default] = klass
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
  end
end
