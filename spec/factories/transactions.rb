FactoryBot.define do
  factory :transaction do
    vat { "9.99" }
    country { "MyString" }
    transaction_type { "MyString" }
    calculation_date { "2024-10-25 10:19:25" }
    buyer { nil }
    product { nil }
  end
end
