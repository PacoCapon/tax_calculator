require 'rails_helper'

RSpec.describe "TaxCalculators", type: :request do
  describe "POST /calculate" do
    it "returns http success" do
      # Definir los parámetros de la solicitud POST
      params = {
        product: {
          name: Faker::Commerce.product_name,
          category: 'digital'
        },
        buyer: {
          country: 'Spain',
          buyer_type: 'individual'
        }
      }

      post "/tax_calculator", params: params

      expect(response).to have_http_status(:success)
    end
  end
end
