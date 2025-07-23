class Schedule < ApplicationRecord
  belongs_to :patient
  has_many :injections, dependent: :destroy

  validates :interval_in_days, numericality: { greater_than: 0 }
  validates :drug_name, presence: true
end
