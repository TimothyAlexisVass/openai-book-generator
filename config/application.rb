require_relative "boot"

require "rails/all"
require "dotenv/load"

Bundler.require(*Rails.groups)

module ChatgptOnRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

  end
end
