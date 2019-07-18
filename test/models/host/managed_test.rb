# frozen_string_literal: true

require 'test_plugin_helper'

module Host
  class ManagedTest < ActiveSupport::TestCase
    should have_many(:host_ssh_keys).dependent(:destroy)
    should have_many(:ssh_keys).through(:host_ssh_keys)

    describe '#active_ssh_keys' do
      let(:host) { FactoryBot.create(:host, :with_ssh_key) }
      let(:host_ssh_key) { host.host_ssh_keys.first }
      let(:ssh_key) { host_ssh_key.ssh_key }

      it 'returns an empty collection if no username is given' do
        assert_empty host.active_ssh_keys
      end

      it 'returns all valid ssh keys for a user' do
        assert_includes host.active_ssh_keys(username: host_ssh_key.username), ssh_key
      end

      it 'returns all valid ssh keys for a user case-insensitive' do
        assert_includes host.active_ssh_keys(username: host_ssh_key.username.upcase), ssh_key
      end

      it 'return filters keys for different user' do
        assert_empty host.active_ssh_keys(username: 'some-other-user')
      end

      it 'filters invalid keys' do
        host
        travel_to Time.zone.now + 1.year do
          assert_empty host.active_ssh_keys(username: host_ssh_key.username)
        end
      end
    end
  end
end
