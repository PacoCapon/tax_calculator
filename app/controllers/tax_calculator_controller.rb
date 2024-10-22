class TaxCalculatorController < ApplicationController
  def calculate
    product = Product.find(params[:product_id])
    buyer = Buyer.find(params[:buyer_id])

    taxes = TaxCalculatorService.new(product, buyer).calculate
    render json: taxes, status: :ok
  end
end
