class Injection < ApplicationRecord
  belongs_to :schedule

  validates :dose, numericality: { greater_than: 0 }
  validates :lot_number, format: { with: /\A#\d{5}\z/, message: "Format: #XXXXX, where X is integer." }
  validates :injected_at, presence: true

  delegate :drug_name, to: :schedule
end
