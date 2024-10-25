class Transaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :product
end
