require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:buyer) { FactoryBot.create(:buyer) }
  let(:product) { FactoryBot.create(:product) }
  let(:transaction) { FactoryBot.build(:transaction, buyer: buyer, product: product) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(transaction).to be_valid
    end

    it 'is not valid without a vat' do
      transaction.vat = nil
      expect(transaction).to_not be_valid
    end

    it 'is not valid without a country' do
      transaction.country = nil
      expect(transaction).to_not be_valid
    end

    it 'is not valid without a transaction_type' do
      transaction.transaction_type = nil
      expect(transaction).to_not be_valid
    end

    it 'is not valid without a calculation_date' do
      transaction.calculation_date = nil
      expect(transaction).to_not be_valid
    end
  end
end