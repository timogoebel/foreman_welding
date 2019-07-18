# frozen_string_literal: true

class HostSshKey < ApplicationRecord
  belongs_to_host
  belongs_to :ssh_key

  validates :username, :valid_from, :valid_to, presence: true
  validate :valid_to_date_after_valid_from_date

  private

  def valid_to_date_after_valid_from_date
    return if valid_from.blank? || valid_to.blank?

    errors.add(:valid_to, _('must be after the valid from date')) if valid_to < valid_from
  end
end
