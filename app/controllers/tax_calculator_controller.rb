class TaxCalculatorController < ApplicationController
  def calculate
    product = Product.find(params[:product_id])
    buyer = Buyer.find(params[:buyer_id])

    tax_amount = TaxCalculatorService.new(product, buyer).calculate

    @tax = tax_amount
    render :result
  end
end
