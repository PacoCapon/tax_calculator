class OnSiteTaxCalculator < BaseTaxCalculator
  def calculate
    { vat: local_vat("ES"), country: @buyer.country, type: [ "service", "onsite" ] }
  end
end
