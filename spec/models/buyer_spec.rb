require 'rails_helper'

RSpec.describe Buyer, type: :model do
  it "is valid with valid attributes" do
    buyer = build(:buyer)
    expect(buyer).to be_valid
  end

  it "is invalid without a name" do
    buyer = build(:buyer, name: nil)
    expect(buyer).to be_invalid
    expect(buyer.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a country" do
    buyer = build(:buyer, country: nil)
    expect(buyer).to be_invalid
    expect(buyer.errors[:country]).to include("can't be blank")
  end

  it "is invalid without a buyer_type" do
    buyer = build(:buyer, buyer_type: nil)
    expect(buyer).to be_invalid
    expect(buyer.errors[:buyer_type]).to include("can't be blank")
  end

  it "is invalid with an incorrect buyer_type" do
    buyer = build(:buyer, buyer_type: "invalid_type")
    expect(buyer).to be_invalid
    expect(buyer.errors[:buyer_type]).to include("invalid_type is not a valid buyer type")
  end
end