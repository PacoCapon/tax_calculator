FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    category { %w[food digital_service onsite_service].sample }
  end
end