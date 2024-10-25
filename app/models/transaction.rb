class Transaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :product

  validates :vat, presence: true
  validates :country, presence: true
  validates :transaction_type, presence: true
  validates :calculation_date, presence: true
end
