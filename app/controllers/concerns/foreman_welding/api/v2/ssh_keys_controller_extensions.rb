# frozen_string_literal: true

module ForemanWelding
  module Api
    module V2
      module SshKeysControllerExtensions
        extend Apipie::DSL::Concern
        extend ActiveSupport::Concern

        included do
          skip_before_action :set_default_response_format, only: [:active_keys]
          skip_before_action :find_user, only: [:active_keys]

          before_action :find_host, only: [:active_keys]
        end

        api :GET, '/ssh_keys/active_keys/:username', N_('List all active SSH keys for a user')
        param :username, String, desc: N_('ID of the user'), required: true

        def active_keys
          @ssh_keys = @host.active_ssh_keys(username: params[:username])

          respond_to do |format|
            format.json
            format.text do
              render plain: @ssh_keys.includes(:user).map(&:to_export).join("\n")
            end
          end
        end

        private

        def find_host
          # TODO: Find using client cert
          @host = Host.first
        end
      end
    end
  end
end
