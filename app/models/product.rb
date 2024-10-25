class Product < ApplicationRecord
  has_many :transactions

  CATEGORIES = %w[food digital_service onsite_service].freeze

  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES, message: "%{value} is not a valid category" }
end
