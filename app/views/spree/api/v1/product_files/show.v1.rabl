object @product_file
attributes *product_file_attributes
attributes :viewable_type, :viewable_id
node("url") { |i| main_app.rails_blob_url(i.attachment) }
