require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RecursionWebsite
  class Application < Rails::Application
  	config.assets.paths << Rails.root.join("app", "assets", "fonts")
    
    config.assets.precompile += Ckeditor.assets	
	config.assets.precompile += %w( ckeditor/* )	
	config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

	config.time_zone = 'Kolkata'
  end
end
