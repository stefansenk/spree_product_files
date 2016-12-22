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


  context "display_name" do
    it "should use the alt name if it is populated" do
      @product_file.update_attributes(alt: 'myfile1', attachment_file_name: 'file1.png')
      expect(@product_file.display_name).to eq 'myfile1'
    end
    it "should use the attachment name if alt is blank" do
      @product_file.update_attributes(alt: nil, attachment_file_name: 'file1.png')
      expect(@product_file.display_name).to eq 'file1.png'
    end
  end
end
