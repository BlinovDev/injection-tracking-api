FactoryBot.define do
  factory :schedule do
    interval_in_days { 1 }
    drug_name { "FactorX" }
    starts_on { "2025-07-23" }
    patient { create(:patient) }
  end
end
