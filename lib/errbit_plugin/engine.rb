# frozen_string_literal: true

module ErrbitPlugin
  class Engine < ::Rails::Engine
    initializer :assets do
      Rails.application.config.assets.paths << root.join("app", "assets", "images", "errbit_plugin")
    end
  end
end
