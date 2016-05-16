require 'spec_helper'

describe Spree::ProductFile do
  before do
    @product = FactoryGirl.create :product
    @product_file = FactoryGirl.create :product_file, viewable: @product
  end
  it "should be valid" do
    expect(@product_file).to be_valid
  end
  it "should have a product as the viewable " do
    expect(@product_file.viewable_type).to eq "Spree::Product"
  end
end
