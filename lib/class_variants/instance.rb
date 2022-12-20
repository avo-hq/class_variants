class ClassVariants::Instance
  attr_reader :classes
  attr_reader :variants
  attr_reader :defaults

  def initialize(classes = "", variants: {}, defaults: {})
    @classes = classes
    @variants = variants
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
end
