require "yaml"

class TaxCalculatorService
  SPAIN_VAT = 0.21

  def initialize(product, buyer)
    @product = product
    @buyer = buyer
    @vat_rates = YAML.load_file(Rails.root.join("config", "vat_rates.yml"))["vat_rates"]
  end

  def calculate
    case @product.category
    when "good"
      calculate_good
    when "digital"
      calculate_digital
    when "onsite"
      calculate_onsite
    else
      raise "Unknown product type"
    end
  end

  private

  def calculate_good
    if @buyer.country == "Spain"
      { vat: local_vat("Spain"), type: "domestic" }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), type: "eu_vat" }
      else
        { vat: 0, type: "reverse_charge" }
      end
    else
      { vat: 0, type: "export" }
    end
  end

  def calculate_digital
    if @buyer.country == "Spain"
      { vat: local_vat("Spain"), type: "domestic" }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), type: "eu_vat" }
      else
        { vat: 0, type: "reverse_charge" }
      end
    else
      { vat: 0, type: "export" }
    end
  end

  def calculate_onsite
    { vat: local_vat("Spain"), type: "domestic" }
  end

  def local_vat(country)
    @vat_rates[country] || 0.21
  end

  def eu_member?(country)
    @vat_rates.keys.include?(country)
  end
end
