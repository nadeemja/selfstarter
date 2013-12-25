require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Selfstarter
  
  class Application < Rails::Application

    # --- Standard Rails Config ---
    config.time_zone = 'Pacific Time (US & Canada)'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_record.whitelist_attributes = true

    config.assets.initialize_on_precompile = false
    
    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.debug = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    # --- Standard Rails Config ---

    config.middleware.use "BraintreeInterceptor" if Rails.env.test?
    
    RPXNow.api_key = "d9fb5168c26f7b1506dfca214a298cb5e73ca5ad"
  end
end