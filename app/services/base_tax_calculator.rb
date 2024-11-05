class BaseTaxCalculator
  def intialize(buyer, vat_rates)
    @buyer = buyer
    @vat_rates = vat_rates
  end

  private

  def local_vat(country)
    @vat_rates[country] || 0.21
  end

  def eu_member?(country)
    @vat_rates.keys.include?(country)
  end
end
