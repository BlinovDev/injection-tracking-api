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
