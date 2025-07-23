FactoryBot.define do
  factory :injection do
    dose { 10 }
    injected_at { DateTime.new(2025, 7, 23, 10, 0, 0) }
    schedule { create(:schedule) }
  end
end
