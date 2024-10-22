class Buyer < ApplicationRecord
  attr_accessor :country, :buyer_type

  def initialize(country, buyer_type)
    @country = country
    @buyer_type = buyer_type
  end
end
