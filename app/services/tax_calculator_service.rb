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
      { vat: local_vat("ES"), type: "domestic" }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), type: "#{@buyer.country.downcase}_vat" }
      else
        { vat: 0, type: "reverse_charge" }
      end
    else
      { vat: 0, type: "export" }
    end
  end

  def calculate_digital
    if @buyer.country == "ES"
      { vat: local_vat("ES"), type: "domestic" }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), type: "#{@buyer.country.downcase}_vat" }
      else
        { vat: 0, type: "reverse_charge" }
      end
    else
      { vat: 0, type: "export" }
    end
  end

  def calculate_onsite
    { vat: local_vat("ES"), type: "domestic" }
  end

  def local_vat(country)
    @vat_rates[country] || 0.21
  end

  def eu_member?(country)
    @vat_rates.keys.include?(country)
  end
end
