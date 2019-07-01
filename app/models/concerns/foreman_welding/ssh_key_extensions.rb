module ForemanWelding
  module SshKeyExtensions
    extend ActiveSupport::Concern

    included do
      has_many :host_ssh_keys, inverse_of: :ssh_key
      has_many :hosts, through: :host_ssh_keys, foreign_key: :host_id
    end
  end
end
