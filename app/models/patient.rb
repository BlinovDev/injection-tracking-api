class Patient < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :injections, through: :schedules

  before_create :generate_api_key
  after_create :create_schedule

  private

  def generate_api_key
    self.api_key ||= SecureRandom.hex(10)
  end

  # TODO: remove after adding proper schedules management
  def create_schedule
    self.schedules.create(interval_in_days: 3, drug_name: 'Adynovate')
  end
end
