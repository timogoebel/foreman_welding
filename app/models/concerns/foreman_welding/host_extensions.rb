# frozen_string_literal: true

module ForemanWelding
  module HostExtensions
    extend ActiveSupport::Concern

    included do
      has_many :host_ssh_keys, inverse_of: :host, foreign_key: :host_id, dependent: :destroy
      has_many :ssh_keys, through: :host_ssh_keys
    end

    def active_ssh_keys(username: nil)
      return SshKey.none if username.blank?

      ssh_keys.where('lower(username) = ?', username.downcase)
              .where('valid_from <= :now AND :now <= valid_to', now: Time.zone.now)
    end
  end
end
