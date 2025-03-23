# frozen_string_literal: true

require "rails/engine"

module ErrbitPlugin
  class Engine < Rails::Engine
    # :nocov:
    initializer :assets do
      Rails.application.config.assets.paths << root.join("app", "assets", "images")
    end
    # :nocov:
  end
end
