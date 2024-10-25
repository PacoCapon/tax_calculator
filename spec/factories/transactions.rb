FactoryBot.define do
  factory :transaction do
    vat { Faker::Number.decimal(l_digits: 2) }
    country { Faker::Address.country_code }
    transaction_type { ["good", "service", "digital"].sample }
    calculation_date { Faker::Date.backward(days: 14) }
    association :buyer
    association :product
  end
end