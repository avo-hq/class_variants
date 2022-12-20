class ClassVariants::Instance
  attr_reader :classes
  attr_reader :variants
  attr_reader :defaults

  def initialize(classes = "", variants: {}, defaults: {})
    @classes = classes
    @variants = expand_boolean_variants(variants)
    @defaults = defaults
  end

  def render(**overrides)
    # Start with our default classes
    result = [@classes]

    # Then merge the passed in overrides on top of the defaults
    @defaults.merge(overrides)
      .each do |variant_type, variant|
        # dig the classes out and add them to the result
        result << @variants.dig(variant_type, variant)
      end

    # Compact out any nil values we may have dug up
    result.compact!

    # Return the final token list
    result.join " "
  end

  private

  def expand_boolean_variants(variants)
    variants.each.map { |key, value|
      case value
      when String
        s_key = key.to_s
        { s_key.delete_prefix("!").to_sym => { !s_key.start_with?("!") => value } }
      else
        { key => value }
      end
    }.reduce do |variants, more_variants|
      variants.merge!(more_variants) { |_key, v1, v2| v1.merge!(v2) }
    end
  end
end
