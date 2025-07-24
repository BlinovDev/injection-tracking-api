class Schedule < ApplicationRecord
  belongs_to :patient
  has_many :injections, dependent: :destroy

  validates :interval_in_days, numericality: { greater_than: 0 }
  validates :drug_name, presence: true

  def adherence_stats(as_of: Date.current)
    start_date = starts_on
    return default_stats if interval_in_days <= 0

    expected_dates = (start_date..as_of).step(interval_in_days).to_a
    actual_dates = injections.pluck(:injected_at).map(&:to_date)

    on_time = expected_dates.count do |expected|
      actual_dates.any? { |actual| (actual - expected).abs <= 1 }
    end

    {
      drug_name: drug_name,
      interval_in_days: interval_in_days,
      starts_on: start_date,
      expected_injections: expected_dates.size,
      actual_injections: actual_dates.size,
      on_time_injections: on_time,
      adherence_score: expected_dates.any? ? (on_time.to_f / actual_dates.size * 100).round : 0
    }
  end

  private

  def default_stats
    {
      drug_name: drug_name,
      interval_in_days: interval_in_days,
      starts_on: starts_on,
      expected_injections: 0,
      actual_injections: 0,
      on_time_injections: 0,
      adherence_score: 0
    }
  end
end
