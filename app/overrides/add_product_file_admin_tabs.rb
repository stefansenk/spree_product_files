Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_product_files_admin_tab',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  partial: 'spree/admin/products/product_files'
)
