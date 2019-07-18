# frozen_string_literal: true

module ForemanWelding
  class Engine < ::Rails::Engine
    engine_name 'foreman_welding'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    initializer 'foreman_welding.load_app_instance_data' do |app|
      ForemanWelding::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_welding.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_welding do
        requires_foreman '>= 1.20'
      end
    end

    config.to_prepare do
      begin
        ::Host::Managed.send(:include, ::ForemanWelding::HostExtensions)
        ::SshKey.send(:include, ::ForemanWelding::SshKeyExtensions)
        ::Api::V2::SshKeysController.send(:include, ::ForemanWelding::Api::V2::SshKeysControllerExtensions)
      #rescue StandardError => e
      #  Rails.logger.warn "ForemanWelding: skipping engine hook (#{e})"
      end
    end
  end
end
