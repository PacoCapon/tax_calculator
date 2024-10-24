require 'rails_helper'

RSpec.describe "buyers/index", type: :view do
  before(:each) do
    assign(:buyers, [
      Buyer.create!(
        name: "Name",
        buyer_type: "Buyer Type",
        country: "Country"
      ),
      Buyer.create!(
        name: "Name",
        buyer_type: "Buyer Type",
        country: "Country"
      )
    ])
  end

  it "renders a list of buyers" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Buyer Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
  end
end
