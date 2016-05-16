Spree::Product.class_eval do
  has_many :product_files, -> { order(:position) }, as: :viewable, dependent: :destroy
end
