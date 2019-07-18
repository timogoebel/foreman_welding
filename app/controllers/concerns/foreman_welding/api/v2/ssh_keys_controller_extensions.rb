# frozen_string_literal: true

module ForemanWelding
  module Api
    module V2
      module SshKeysControllerExtensions
        extend Apipie::DSL::Concern
        extend ActiveSupport::Concern

        included do
          skip_before_action :find_user, only: [:active_keys]

          before_action :find_host, only: [:active_keys]
        end

        api :GET, '/ssh_keys/active_keys/:username', N_('List all active SSH keys for a host identified by client cert')
        api :GET, '/hosts/:host_id/ssh_keys/active_keys/:username', N_('List all active SSH keys for a host')
        param :host_id, String, desc: N_('ID or name of the host')
        param :username, String, desc: N_('name of the system user'), required: true

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

        def action_permission
          case params[:action]
          when 'active_keys'
            :view
          else
            super
          end
        end

        def find_host
          # TODO: Find using client cert
          find_optional_nested_object
          @host = @nested_obj if @nested_obj.is_a?(Host::Base)
          not_found unless @host
        end

        def allowed_nested_id
          ['host_id']
        end
      end
    end
  end
end
