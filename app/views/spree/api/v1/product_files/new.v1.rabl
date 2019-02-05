object false
node(:attributes) { [*product_file_attributes] }
node(:required_attributes) { required_fields_for(Spree::ProductFile) }
