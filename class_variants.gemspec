require_relative "lib/class_variants/version"

Gem::Specification.new do |s|
  s.name        = "class_variants"
  s.version     = ClassVariants::VERSION
  s.summary     = "Easily configure styles and apply them as classes."
  s.description = "Easily configure styles and apply them as classes."
  s.authors     = ["Adrian Marin"]
  s.email       = "adrian@adrianthedev.com"
  s.files       = ["lib/class_variants.rb"]
  s.homepage    = "https://github.com/avo-hq/class_variants"
  s.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata["bug_tracker_uri"] = "https://github.com/avo-hq/class_variants/issues"
    s.metadata["homepage_uri"] = "https://github.com/avo-hq/class_variants"
    s.metadata["source_code_uri"] = "https://github.com/avo-hq/class_variants"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
end

