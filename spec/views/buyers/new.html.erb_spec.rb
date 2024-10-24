require 'rails_helper'

RSpec.describe "buyers/new", type: :view do
  before(:each) do
    assign(:buyer, Buyer.new(
      name: "MyString",
      buyer_type: "MyString",
      country: "MyString"
    ))
  end

  it "renders new buyer form" do
    render

    assert_select "form[action=?][method=?]", buyers_path, "post" do

      assert_select "input[name=?]", "buyer[name]"

      assert_select "input[name=?]", "buyer[buyer_type]"

      assert_select "input[name=?]", "buyer[country]"
    end
  end
end
