class HostSshKey < ApplicationRecord
  belongs_to_host
  belongs_to :ssh_key

  validates :username, :valid_from, :valid_to, presence: true
  validate :valid_to_date_after_valid_from_date

  private

  def valid_to_date_after_valid_from_date
    return if valid_from.blank? || valid_to.blank?

    if valid_to < valid_from
      errors.add(:valid_from, _('must be after the valid from date'))
    end
  end
end
