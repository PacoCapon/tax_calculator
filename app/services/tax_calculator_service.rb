require "yaml"

class TaxCalculatorService
  CALCULATOR_CLASSES =  {
    "food" => GoddTaxCalculator,
    "ditial_service" => DigitalTaxCalculator,
    "onsite_service" => OnSiteTaxCalculator
  }

  def initialize(product, buyer)
    @product = product
    @buyer = buyer
    @vat_rates = YAML.load_file(Rails.root.join("config", "vat_rates.yml"))["vat_rates"]
  end

  def calculate
    calculator_class = CALCULATOR_CLASSES[@product.category]
    raise "Unknown product type" unless calculator_class

    calculator = search_calculator_class.new(@buyer, @vat_rates)
    result = calculator.calculate

    Transaction.create(
      vat: result[:vat],
      country: result[:country],
      transaction_type: result[:type].join(", "),
      calculation_date: Time.now,
      buyer: @buyer,
      product: @product
    )

    result
  end
end
