Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_product_files_to_product',
  insert_bottom: '[data-hook="product_description"]',
  partial: 'spree/products/product_files'
)
