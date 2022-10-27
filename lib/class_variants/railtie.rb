require 'rails/railtie'

module ClassVariants
  class Railtie < ::Rails::Railtie
    initializer "class_variants.action_view" do |app|
      ActiveSupport.on_load :action_view do
        require "class_variants/action_view/helpers"
        include ClassVariants::ActionView::Helpers
      end
    end
  end
end