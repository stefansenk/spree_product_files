object @product_file
attributes *product_file_attributes
attributes :viewable_type, :viewable_id
node("url") { |i| i.attachment.url }
