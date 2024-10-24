require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/buyers", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Buyer. As you add validations to Buyer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Buyer.create! valid_attributes
      get buyers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      buyer = Buyer.create! valid_attributes
      get buyer_url(buyer)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_buyer_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      buyer = Buyer.create! valid_attributes
      get edit_buyer_url(buyer)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Buyer" do
        expect {
          post buyers_url, params: { buyer: valid_attributes }
        }.to change(Buyer, :count).by(1)
      end

      it "redirects to the created buyer" do
        post buyers_url, params: { buyer: valid_attributes }
        expect(response).to redirect_to(buyer_url(Buyer.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Buyer" do
        expect {
          post buyers_url, params: { buyer: invalid_attributes }
        }.to change(Buyer, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post buyers_url, params: { buyer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested buyer" do
        buyer = Buyer.create! valid_attributes
        patch buyer_url(buyer), params: { buyer: new_attributes }
        buyer.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the buyer" do
        buyer = Buyer.create! valid_attributes
        patch buyer_url(buyer), params: { buyer: new_attributes }
        buyer.reload
        expect(response).to redirect_to(buyer_url(buyer))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        buyer = Buyer.create! valid_attributes
        patch buyer_url(buyer), params: { buyer: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested buyer" do
      buyer = Buyer.create! valid_attributes
      expect {
        delete buyer_url(buyer)
      }.to change(Buyer, :count).by(-1)
    end

    it "redirects to the buyers list" do
      buyer = Buyer.create! valid_attributes
      delete buyer_url(buyer)
      expect(response).to redirect_to(buyers_url)
    end
  end
end
