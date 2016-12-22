module Spree
  module Admin
    class ProductFilesController < ResourceController
      before_action :load_edit_data, except: :index
      before_action :load_index_data, only: :index

      create.before :set_viewable
      update.before :set_viewable
      create.fails :set_flash_error_messages_from_object

      private

      def location_after_destroy
        admin_product_product_files_url(@product)
      end

      def location_after_save
        admin_product_product_files_url(@product)
      end

      def load_index_data
        @product = Product.friendly.find(params[:product_id])
      end

      def load_edit_data
        @product = Product.friendly.find(params[:product_id])
      end

      def set_viewable
        @product_file.viewable_type = 'Spree::Product'
        @product_file.viewable_id = @product.id
      end

      def variant_index_includes
        [
          variant_product_files: [viewable: { option_values: :option_type }]
        ]
      end

      def variant_edit_includes
        [
          variants_including_master: { option_values: :option_type, product_files: :viewable }
        ]
      end

      def set_flash_error_messages_from_object
        flash[:error] = @object.errors.full_messages.join(', ')
      end

    end
  end
end
