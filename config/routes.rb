# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    scope '(:apiv)', module: :v2,
                     defaults: { apiv: 'v2' },
                     apiv: /v2/,
                     constraints: ApiConstraints.new(version: 2, default: true) do
      constraints(id: %r{[^/]+}) do
        resources :ssh_keys, only: [] do
          get ':active_keys(/:username)', on: :collection, action: :active_keys, controller: 'ssh_keys'
        end
      end
    end
  end
end
