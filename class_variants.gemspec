require_relative "lib/class_variants/version"

Gem::Specification.new do |s|
  # information
  s.name = "class_variants"
  s.version = ClassVariants::VERSION
  s.summary = "Easily configure styles and apply them as classes."
  s.description = "Easily configure styles and apply them as classes."
  s.authors = ["Adrian Marin"]
  s.email = "adrian@adrianthedev.com"
  s.homepage = "https://github.com/avo-hq/class_variants"
  s.license = "MIT"

  # metadata
  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = s.homepage
  s.metadata["bug_tracker_uri"] = "#{s.homepage}/issues"
  s.metadata["changelog_uri"] = "#{s.homepage}/releases"

  # gem files
  s.files = Dir["lib/**/*", "LICENSE", "README.md"]

  # ruby minimal version
  s.required_ruby_version = Gem::Requirement.new(">= 3.0")
end
