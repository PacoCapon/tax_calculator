class TaxCalculatorController < ApplicationController
  def calculate
    product = Product.find(params[:product_id])
    buyer = Buyer.find(params[:buyer_id])

    tax_amount = TaxCalculatorService.new(product, buyer).calculate

    render :result, locals: { tax_amount: tax_amount }
  end
end
