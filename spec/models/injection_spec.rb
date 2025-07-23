require 'rails_helper'

describe Injection, type: :model do
  it "is valid with correct lot_number format" do
    injection = build(:injection, lot_number: "#12345")

    expect(injection).to be_valid
  end

  it "is invalid with incorrect lot_number format" do
    injection = build(:injection, lot_number: "#123456")

    expect(injection).not_to be_valid
  end

  it "is invalid without injected_at" do
    expect(build(:injection, injected_at: nil)).not_to be_valid
  end

  it "is invalid with non-positive dose" do
    expect(build(:injection, dose: 0)).not_to be_valid
  end
end
