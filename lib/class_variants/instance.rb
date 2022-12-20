class ClassVariants::Instance
  attr_reader :classes
  attr_reader :variants
  attr_reader :defaults

  def initialize(classes = "", variants: {}, defaults: {})
    @classes = classes
    @variants = variants
    @defaults = defaults
  end

  def render(**settings)
    result = []

    # Add the default classes if any provided
    result << classes if classes

    # Keep the applied variants so we can later apply the defaults
    applied_options = []

    # Go through each keys provided
    settings.each do |key, value|
      if variants.keys.include? key
        applied_options << key
        result << variants[key][value]
      end
    end

    if defaults && !defaults.empty?
      defaults.each do |key, key_to_use|
        unless applied_options.include? key
          result << @variants[key][key_to_use] if @variants[key] && !@variants[key].empty?
        end
      end
    end

    result.join " "
  end
end
