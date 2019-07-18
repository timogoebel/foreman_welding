require 'test_plugin_helper'

class Api::V2::SshKeysControllerTest < ActionController::TestCase
  describe '#active_keys' do
    setup do
      @host = FactoryBot.create(:host, :with_ssh_key)
    end

    context 'with a host parameter' do
      context 'requesting json' do
        it 'lists the ssh keys json formatted' do
          get :active_keys, params: { username: 'foreman-user', host_id: @host.to_param }
          assert_response :success
          assert_includes @response.headers['Content-Type'], 'application/json'
          results = ActiveSupport::JSON.decode(@response.body)
          assert_not_empty results
          actual = results.first
          expected = @host.ssh_keys.first
          assert_equal expected.id, actual['id']
          assert_equal expected.name, actual['name']
          assert_equal expected.key, actual['key']
          assert_equal expected.length, actual['length']
          assert_equal expected.fingerprint, actual['fingerprint']
        end
      end

      context 'requesting text' do
        it 'lists the ssh keys plain text formatted' do
          expected = @host.ssh_keys.first.to_export

          get :active_keys, params: { username: 'foreman-user', host_id: @host.to_param }, format: :text
          assert_response :success
          assert_includes @response.headers['Content-Type'], 'text/plain'
          assert_not_empty @response.body
          assert_equal expected, @response.body
        end
      end
    end
  end
end
