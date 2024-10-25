
require 'faker'

# Clean database
Transaction.destroy_all
Product.destroy_all
Buyer.destroy_all

# Create some buyers
5.times do
  Buyer.create!(
    name: Faker::Name.name,
    buyer_type: ["individual", "company"].sample,
    country: Faker::Address.country_code
  )
end

# Create some products
categories = ["food", "digital_service", "onsite_service"]

10.times do
  Product.create!(
    name: Faker::Food.dish,
    category: categories.sample
  )
end

# Create some transactions
buyers = Buyer.all
products = Product.all

10.times do
  vat_value = rand(0..24) + rand.round(2)
  Transaction.create!(
    vat: vat_value,
    country: buyers.sample.country,
    transaction_type: ["good", "service", "digital"].sample,
    calculation_date: Faker::Date.backward(days: 14),
    buyer: buyers.sample,
    product: products.sample
  )
end

puts "#{Buyer.count} buyers, #{Product.count} products and #{Transaction.count} transactions were created."