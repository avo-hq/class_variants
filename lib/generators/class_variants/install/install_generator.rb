# frozen_string_literal: true

module ClassVariants
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_initializer
        template "class_variants.rb", "config/initializers/class_variants.rb"
      end
    end
  end
end
