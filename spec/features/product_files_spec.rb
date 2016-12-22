require 'spec_helper'

describe "Product Files", type: :feature do
  before do
    @product = FactoryGirl.create :product
    @product_file = FactoryGirl.create :product_file, viewable: @product, alt: 'Data File 1'
  end
  it "should display the link to the file" do
    visit spree.product_path @product
    expect(page).to have_content 'Data File 1'
  end
end
