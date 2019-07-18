# frozen_string_literal: true

FactoryBot.modify do
  factory :host do
    trait :with_ssh_key do
      host_ssh_keys { build_list :host_ssh_key, 1 }
    end
  end
end
