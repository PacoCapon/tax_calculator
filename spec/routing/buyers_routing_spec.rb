require "rails_helper"

RSpec.describe BuyersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/buyers").to route_to("buyers#index")
    end

    it "routes to #new" do
      expect(get: "/buyers/new").to route_to("buyers#new")
    end

    it "routes to #show" do
      expect(get: "/buyers/1").to route_to("buyers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/buyers/1/edit").to route_to("buyers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/buyers").to route_to("buyers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/buyers/1").to route_to("buyers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/buyers/1").to route_to("buyers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/buyers/1").to route_to("buyers#destroy", id: "1")
    end
  end
end
