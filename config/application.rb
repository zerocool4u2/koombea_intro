require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KoombeaIntro
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    config.time_zone = 'Bogota'

    # The default locale is :es and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]
    config.active_model.i18n_customize_full_message = true

    overrides = "#{ Rails.root }/app/modules"

    Rails.autoloaders.main.ignore(overrides)

    config.to_prepare do
      Dir.glob("#{ overrides }/**/*.rb").each do |override|
        load override
      end
    end
  end
end
