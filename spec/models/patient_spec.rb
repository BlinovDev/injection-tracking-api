require 'rails_helper'

describe Patient, type: :model do
  subject { create(:patient) }

  it "generates api_key before creation" do
    expect(subject.api_key).to be_present
    expect(subject.api_key.length).to eq 20
  end

  it "has a unique api_key" do
    other = create(:patient)

    expect(subject.api_key).not_to eq(other.api_key)
  end
end

describe "after_create :create_schedule" do
  it "automatically creates a schedule when patient is created" do
    patient = create(:patient)
    expect(patient.schedules.count).to eq(1)

    schedule = patient.schedules.first
    expect(schedule.interval_in_days).to eq(3)
    expect(schedule.drug_name).to eq("Adynovate")
  end
end
