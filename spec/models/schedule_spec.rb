require 'rails_helper'

describe Schedule, type: :model do
  it "is invalid without drug_name" do
    schedule = build(:schedule, drug_name: nil)

    expect(schedule).not_to be_valid
  end

  it "is invalid with non-positive interval" do
    schedule = build(:schedule, interval_in_days: 0)

    expect(schedule).not_to be_valid
  end
end

describe "#adherence_stats" do
  let(:schedule) { create(:schedule, interval_in_days: 3, starts_on: Date.today - 12.days) }

  before do
    create(:injection, schedule: schedule, injected_at: Date.today - 11.days)
    create(:injection, schedule: schedule, injected_at: Date.today - 8.days)
    create(:injection, schedule: schedule, injected_at: Date.today - 5.days)
  end

  it "calculates correct adherence" do
    stats = schedule.adherence_stats

    expect(stats[:expected_injections]).to eq(5)
    expect(stats[:actual_injections]).to eq(3)
    expect(stats[:on_time_injections]).to be_between(2, 3)
    expect(stats[:adherence_score]).to be <= 100
  end
end
