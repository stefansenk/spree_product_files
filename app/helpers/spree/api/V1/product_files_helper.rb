module Spree
  module Api
    module V1
      module ProductFilesHelper

        @@product_file_attributes = [
          :id, :position, :attachment_content_type, :attachment_file_name, :type, :attachment_updated_at, :alt
        ]

        def product_file_attributes
          @@product_file_attributes
        end

      end
    end
  end
end
