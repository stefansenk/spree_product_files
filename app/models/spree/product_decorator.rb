module Spree::ProductDecorator
  def self.prepended(base)
    base.has_many :product_files, -> { order(:position) }, as: :viewable, dependent: :destroy
  end
end

::Spree::Product.prepend ::Spree::ProductDecorator
