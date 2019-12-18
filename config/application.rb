require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"

Bundler.require(*Rails.groups)

module MywebappApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.api_only = true
    config.settings = File.join(Rails.root, 'config', 'application.yml')
    config.generators do |g|
      g.test_framework  nil
      g.view_specs      false
      g.helper_specs    false
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
