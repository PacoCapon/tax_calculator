class Buyer < ApplicationRecord
  has_many :transactions

  BUYER_TYPES = %w[individual company].freeze

  validates :name, presence: true
  validates :country, presence: true
  validates :buyer_type, presence: true, inclusion: { in: BUYER_TYPES, message: "%{value} is not a valid buyer type" }
end
