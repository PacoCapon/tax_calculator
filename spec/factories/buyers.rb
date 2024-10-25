FactoryBot.define do
  factory :buyer do
    name { Faker::Name.name }
    country { Faker::Address.country }
    buyer_type { %w[individual company].sample }
  end
end