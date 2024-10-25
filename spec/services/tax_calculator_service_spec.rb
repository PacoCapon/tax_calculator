require 'rails_helper'

RSpec.describe TaxCalculatorService, type: :service do
  let(:vat_rates) do
    {
      "AT" => 0.20,  # Austria
      "BE" => 0.21,  # Belgium
      "BG" => 0.20,  # Bulgaria
      "HR" => 0.25,  # Croatia
      "CY" => 0.19,  # Cyprus
      "CZ" => 0.21,  # Czech Republic
      "DK" => 0.25,  # Denmark
      "EE" => 0.20,  # Estonia
      "FI" => 0.24,  # Finland
      "FR" => 0.20,  # France
      "DE" => 0.19,  # Germany
      "GR" => 0.24,  # Greece
      "HU" => 0.27,  # Hungary
      "IE" => 0.23,  # Ireland
      "IT" => 0.22,  # Italy
      "LV" => 0.21,  # Latvia
      "LT" => 0.21,  # Lithuania
      "LU" => 0.17,  # Luxembourg
      "MT" => 0.18,  # Malta
      "NL" => 0.21,  # Netherlands
      "PL" => 0.23,  # Poland
      "PT" => 0.23,  # Portugal
      "RO" => 0.19,  # Romania
      "SK" => 0.20,  # Slovakia
      "SI" => 0.22,  # Slovenia
      "ES" => 0.21,  # Spain
      "SE" => 0.25   # Sweden
    }
  end

  before do
    allow(YAML).to receive(:load_file).and_return({ "vat_rates" => vat_rates })
  end

  let(:buyer_spain_individual) { build(:buyer, country: "ES", buyer_type: "individual") }
  let(:buyer_spain_company) { build(:buyer, country: "ES", buyer_type: "company") }
  let(:buyer_eu_individual) { build(:buyer, country: "FR", buyer_type: "individual") }
  let(:buyer_eu_company) { build(:buyer, country: "DE", buyer_type: "company") }
  let(:buyer_non_eu) { build(:buyer, country: "US", buyer_type: "individual") }

  describe "#calculate" do
    context "when product category is food" do
      let(:product) { build(:product, category: "food") }

      it "applies Spanish VAT for a buyer in Spain" do
        result = TaxCalculatorService.new(product, buyer_spain_individual).calculate
        expect(result).to eq({ vat: 0.21, country: "ES", type: %w(good) })
      end

      it "applies local VAT for an individual buyer in the EU" do
        result = TaxCalculatorService.new(product, buyer_eu_individual).calculate
        expect(result).to eq({ vat: 0.20, country: "ES", type: %w(good) })
      end

      it "applies reverse charge for a company buyer in the EU" do
        result = TaxCalculatorService.new(product, buyer_eu_company).calculate
        expect(result).to eq({ vat: 0, country: "DE", type: %w(reverse_charge) })
      end

      it "applies export rules for a buyer outside the EU" do
        result = TaxCalculatorService.new(product, buyer_non_eu).calculate
        expect(result).to eq({ vat: 0, country: "US", type: %w(export) })
      end
    end

    context "when product category is digital_service" do
      let(:product) { build(:product, category: "digital_service") }

      it "applies Spanish VAT for a buyer in Spain" do
        result = TaxCalculatorService.new(product, buyer_spain_individual).calculate
        expect(result).to eq({ vat: 0.21, country: "ES", type: %w(service digital) })
      end

      it "applies local VAT for an individual buyer in the EU" do
        result = TaxCalculatorService.new(product, buyer_eu_individual).calculate
        expect(result).to eq({ vat: 0.20, country: "FR", type: %w(service digital) })
      end

      it "applies reverse charge for a company buyer in the EU" do
        result = TaxCalculatorService.new(product, buyer_eu_company).calculate
        expect(result).to eq({ vat: 0, country: "DE", type: %w(reverse_charge) })
      end

      it "applies export rules for a buyer outside the EU" do
        result = TaxCalculatorService.new(product, buyer_non_eu).calculate
        expect(result).to eq({ vat: 0, country: "US", type: %w(export) })
      end
    end

    context "when product category is onsite_service" do
      let(:product) { build(:product, category: "onsite_service") }

      it "always applies Spanish VAT regardless of buyer's location" do
        result_spain = TaxCalculatorService.new(product, buyer_spain_individual).calculate
        result_eu = TaxCalculatorService.new(product, buyer_eu_individual).calculate
        result_non_eu = TaxCalculatorService.new(product, buyer_non_eu).calculate

        expect(result_spain).to eq({ vat: 0.21, country: "ES", type: %w(service onsite) })
        expect(result_eu).to eq({ vat: 0.21, country: "FR", type: %w(service onsite) })
        expect(result_non_eu).to eq({ vat: 0.21, country: "US", type: %w(service onsite) })
      end
    end
  end
end