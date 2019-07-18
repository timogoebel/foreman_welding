# frozen_string_literal: true

FactoryBot.define do
  factory :host_ssh_key do
    valid_from { Time.zone.now - 5.days }
    valid_to { Time.zone.now + 5.days }
    host
    ssh_key
    username { 'foreman-user' }
  end
end
