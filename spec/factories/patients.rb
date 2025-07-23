FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
  end
end
