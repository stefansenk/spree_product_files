module Spree
  module Api
    module V1
      class ProductFilesController < Spree::Api::BaseController

        helper ::SpreeApiV1ProductFilesHelper

        def index
          @product_files = scope.product_files.accessible_by(current_ability, :read)
          respond_with(@product_files)
        end

        def show
          @product_file = ProductFile.accessible_by(current_ability, :read).find(params[:id])
          respond_with(@product_file)
        end

        def create
          authorize! :create, ProductFile
          @product_file = scope.product_files.new(product_file_params)
          if @product_file.save
            respond_with(@product_file, status: 201, default_template: :show)
          else
            invalid_resource!(@product_file)
          end
        end

        def update
          @product_file = scope.product_files.accessible_by(current_ability, :update).find(params[:id])
          if @product_file.update_attributes(product_file_params)
            respond_with(@product_file, default_template: :show)
          else
            invalid_resource!(@product_file)
          end
        end

        def destroy
          @product_file = scope.product_files.accessible_by(current_ability, :destroy).find(params[:id])
          @product_file.destroy
          respond_with(@product_file, status: 204)
        end

        private

        def permitted_product_file_attributes
          [:alt, :attachment, :position, :viewable_type, :viewable_id]
        end

        def product_file_params
          params.require(:product_file).permit(permitted_product_file_attributes)
        end

        def scope
          if params[:product_id]
            Spree::Product.friendly.find(params[:product_id])
          elsif params[:variant_id]
            Spree::Variant.find(params[:variant_id])
          end
        end
      end
    end
  end
end
