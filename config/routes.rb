# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    scope '(:apiv)', module: :v2,
      defaults: { apiv: 'v2' },
      apiv: /v2/,
      constraints: ApiConstraints.new(version: 2, default: true) do
        constraints(id: /[^\/]+/) do
          resources :hosts, only: [] do
            resources :ssh_keys, only: [] do
              collection do
                get 'active_keys/:username', to: 'ssh_keys#active_keys'
              end
            end
          end
        end

        resources :ssh_keys, only: [] do
          collection do
            get 'active_keys/:username', to: 'ssh_keys#active_keys'
          end
        end
      end
  end
end
