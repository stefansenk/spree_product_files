FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_product_files/factories'

  factory :product_file, class: Spree::ProductFile do
    attachment { File.new(Spree::Core::Engine.root + "spec/fixtures" + 'thinking-cat.jpg') }
  end
end
