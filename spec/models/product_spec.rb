require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "is invalid without a name" do
    product = build(:product, name: nil)
    expect(product).to be_invalid
    expect(product.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a category" do
    product = build(:product, category: nil)
    expect(product).to be_invalid
    expect(product.errors[:category]).to include("can't be blank")
  end

  it "is invalid with an incorrect category" do
    product = build(:product, category: "invalid_category")
    expect(product).to be_invalid
    expect(product.errors[:category]).to include("invalid_category is not a valid category")
  end
end