module ClassVariants
  class Instance
    attr_reader :base, :variants, :compound_variants, :defaults

    # rubocop:disable Naming/VariableName
    def initialize(classes = nil, base: nil, variants: {}, compoundVariants: [], compound_variants: [], defaults: {})
      warn <<~MSG if classes
        (ClassVariants) DEPRECATION WARNING: Use of positional argument for default classes is deprecated
        and will be removed in the next version. Use the `base` keyword argument instead.
      MSG

      warn <<~MSG unless compoundVariants.empty?
        (ClassVariants) DEPRECATION WARNING: Use of `compoundVariants` keyword argument is deprecated
        and will be removed in the next version. Use the `compound_variant` instead.
      MSG

      @base = base || classes
      @variants = expand_boolean_variants(variants)
      @compound_variants = compound_variants.empty? ? compoundVariants : compound_variants
      @defaults = defaults
    end
    # rubocop:enable Naming/VariableName

    def render(**overrides)
      # Start with our default classes
      result = [@base]

      # Then merge the passed in overrides on top of the defaults
      selected = @defaults.merge(overrides)

      selected.each do |variant_type, variant|
        # dig the classes out and add them to the result
        result << @variants.dig(variant_type, variant)
      end

      @compound_variants.each do |compound_variant|
        if (compound_variant.keys - [:class]).all? { |key| selected[key] == compound_variant[key] }
          result << compound_variant[:class]
        end
      end

      # Compact out any nil values we may have dug up
      result.compact!

      # Return the final token list
      result.join " "
    end

    private

    def expand_boolean_variants(variants)
      expanded = variants.map do |key, value|
        case value
        when String
          s_key = key.to_s
          {s_key.delete_prefix("!").to_sym => {!s_key.start_with?("!") => value}}
        else
          {key => value}
        end
      end

      expanded.reduce do |output, next_variant|
        output.merge!(next_variant) { |_key, v1, v2| v1.merge!(v2) }
      end
    end
  end
end
