require "yaml"

class TaxCalculatorService
  def initialize(product, buyer)
    @product = product
    @buyer = buyer
    @vat_rates = YAML.load_file(Rails.root.join("config", "vat_rates.yml"))["vat_rates"]
  end

  def calculate
    case @product.category
    when "food"
      calculate_good
    when "digital_service"
      calculate_digital
    when "onsite_service"
      calculate_onsite
    else
      raise "Unknown product type"
    end
  end

  private

  def calculate_good
    if @buyer.country == "ES"
      { vat: local_vat("ES"), country: "ES", type: ["good"] }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), country: "ES", type: ["good"] }
      else
        { vat: 0, country: @buyer.country, type: ["reverse_charge"] }
      end
    else
      { vat: 0, country: @buyer.country, type: ["export"] }
    end
  end

  def calculate_digital
    if @buyer.country == "ES"
      { vat: local_vat("ES"), country: "ES", type: ["service", "digital"] }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), country: @buyer.country, type: ["service", "digital"] }
      else
        { vat: 0, country: @buyer.country, type: ["reverse_charge"] }
      end
    else
      { vat: 0, country: @buyer.country, type: ["export"] }
    end
  end

  def calculate_onsite
    { vat: local_vat("ES"), country: @buyer.country, type: ["service", "onsite"] }
  end

  def local_vat(country)
    @vat_rates[country] || 0.21
  end

  def eu_member?(country)
    @vat_rates.keys.include?(country)
  end
end
