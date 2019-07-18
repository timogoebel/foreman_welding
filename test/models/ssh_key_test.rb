# frozen_string_literal: true

require 'test_plugin_helper'

class SshKeyTest < ActiveSupport::TestCase
  should have_many(:host_ssh_keys).dependent(:destroy)
  should have_many(:hosts).through(:host_ssh_keys)
end
