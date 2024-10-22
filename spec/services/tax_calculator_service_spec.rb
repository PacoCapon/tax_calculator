require 'rails_helper'
require 'faker'

RSpec.describe TaxCalculatorService, type: :service do
  before do
    # Fijamos los datos generados por Faker para asegurar que las pruebas sean reproducibles
    Faker::Config.random = Random.new(42)
  end

  let(:product_digital) { Product.create(name: Faker::Commerce.product_name, category: 'digital') }
  let(:product_good) { Product.create(name: Faker::Food.ingredient, category: 'good') }
  let(:buyer_spain) { Buyer.create(country: 'Spain', buyer_type: 'individual') }
  let(:buyer_france) { Buyer.create(country: 'France', buyer_type: 'individual') }
  let(:buyer_germany_company) { Buyer.create(country: 'Germany', buyer_type: 'company') }
  let(:buyer_usa) { Buyer.create(country: 'USA', buyer_type: 'individual') }

  describe '#calculate' do
    context 'digital service' do
      it 'applies Spain VAT for digital service sold in Spain' do
        service = TaxCalculatorService.new(product_digital, buyer_spain)
        result = service.calculate
        expect(result[:vat]).to eq(0.21)
        expect(result[:type]).to eq('domestic')
      end

      it 'applies France VAT for EU individual buyer' do
        service = TaxCalculatorService.new(product_digital, buyer_france)
        result = service.calculate
        expect(result[:vat]).to eq(0.20)
        expect(result[:type]).to eq('eu_vat')
      end

      it 'marks reverse charge for EU company buyer from Germany' do
        service = TaxCalculatorService.new(product_digital, buyer_germany_company)
        result = service.calculate
        expect(result[:vat]).to eq(0)
        expect(result[:type]).to eq('reverse_charge')
      end

      it 'marks export for outside EU buyer' do
        service = TaxCalculatorService.new(product_digital, buyer_usa)
        result = service.calculate
        expect(result[:vat]).to eq(0)
        expect(result[:type]).to eq('export')
      end
    end

    context 'good' do
      it 'applies Spain VAT for goods sold in Spain' do
        service = TaxCalculatorService.new(product_good, buyer_spain)
        result = service.calculate
        expect(result[:vat]).to eq(0.21)
        expect(result[:type]).to eq('domestic')
      end

      it 'applies France VAT for EU individual buyer' do
        service = TaxCalculatorService.new(product_good, buyer_france)
        result = service.calculate
        expect(result[:vat]).to eq(0.20)
        expect(result[:type]).to eq('eu_vat')
      end

      it 'marks reverse charge for EU company buyer' do
        service = TaxCalculatorService.new(product_good, buyer_germany_company)
        result = service.calculate
        expect(result[:vat]).to eq(0)
        expect(result[:type]).to eq('reverse_charge')
      end

      it 'marks export for outisde EU buyer' do
        service = TaxCalculatorService.new(product_good, buyer_usa)
        result = service.calculate
        expect(result[:vat]).to eq(0)
        expect(result[:type]).to eq('export')
      end
    end
  end
end
