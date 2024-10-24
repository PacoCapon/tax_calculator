require 'rails_helper'

RSpec.describe "buyers/edit", type: :view do
  let(:buyer) {
    Buyer.create!(
      name: "MyString",
      buyer_type: "MyString",
      country: "MyString"
    )
  }

  before(:each) do
    assign(:buyer, buyer)
  end

  it "renders the edit buyer form" do
    render

    assert_select "form[action=?][method=?]", buyer_path(buyer), "post" do

      assert_select "input[name=?]", "buyer[name]"

      assert_select "input[name=?]", "buyer[buyer_type]"

      assert_select "input[name=?]", "buyer[country]"
    end
  end
end
