class TaxCalculatorController < ApplicationController
  def calculate
    product_name = params[:name]
    product_category = params[:category]
    buyer_country = params[:country]
    buyer_type = params[:buyer_type]

    tax_amount = TaxCalculatorService.new(product_name, product_category, buyer_country, buyer_type).calculate

    @tax = tax_amount
    render :result
  end
end
