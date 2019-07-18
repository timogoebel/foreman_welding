# frozen_string_literal: true

require 'test_plugin_helper'

class HostSshKeyTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_presence_of(:valid_from)
  should validate_presence_of(:valid_to)
  should belong_to(:ssh_key)
  should belong_to(:host)

  describe 'validations' do
    context 'with valid from date after valid to date' do
      let(:host_ssh_key) { FactoryBot.build(:host_ssh_key, valid_from: Time.zone.now, valid_to: Time.zone.now - 3.days) }

      it 'is invalid' do
        refute_valid host_ssh_key
        assert_includes host_ssh_key.errors.keys, :valid_to
      end
    end
  end
end
