require 'rails_helper'

RSpec.describe "buyers/show", type: :view do
  before(:each) do
    assign(:buyer, Buyer.create!(
      name: "Name",
      buyer_type: "Buyer Type",
      country: "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Buyer Type/)
    expect(rendered).to match(/Country/)
  end
end
