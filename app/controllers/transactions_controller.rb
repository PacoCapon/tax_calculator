class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:buyer, :product).all
  end
end
