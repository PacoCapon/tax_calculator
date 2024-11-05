class GoddTaxCalculator < BaseTaxCalculator
  def calculate
    if @buyer.country == "ES"
      { vat: local_vat("ES"), country: "ES", type: [ "good" ] }
    elsif eu_member?(@buyer.country)
      if @buyer.buyer_type == "individual"
        { vat: local_vat(@buyer.country), country: @buyer.country, type: [ "good" ] }
      else
        { vat: 0, country: @buyer.country, type: [ "reverse_charge" ] }
      end
    else
      { vat: 0, country: @buyer.country, type: [ "export" ] }
    end
  end
end
