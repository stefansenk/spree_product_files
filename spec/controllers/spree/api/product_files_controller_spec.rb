require 'spec_helper'

module Spree
  describe Api::V1::ProductFilesController, :type => :controller do

    def api_get(action, params={}, session=nil, flash=nil)
      api_process(action, params, session, flash, "GET")
    end
    def api_post(action, params={}, session=nil, flash=nil)
      api_process(action, params, session, flash, "POST")
    end
    def api_put(action, params={}, session=nil, flash=nil)
      api_process(action, params, session, flash, "PUT")
    end
    def api_delete(action, params={}, session=nil, flash=nil)
      api_process(action, params, session, flash, "DELETE")
    end
    def api_process(action, params={}, session=nil, flash=nil, method="get")
      scoping = respond_to?(:resource_scoping) ? resource_scoping : {}
      process(action, method, params.merge(scoping).reverse_merge!(:format => :json), session, flash)
    end
    def json_response
      case body = JSON.parse(response.body)
      when Hash
        body.with_indifferent_access
      when Array
        body
      end
    end
    def assert_not_found!
      expect(json_response).to eq({ "error" => "The resource you were looking for could not be found." })
      expect(response.status).to eq 404
    end
    def assert_unauthorized!
      expect(json_response).to eq({ "error" => "You are not authorized to perform that action." })
      expect(response.status).to eq 401
    end
    def upload_product_file(filename)
      Rack::Test::UploadedFile.new(File.open(Spree::Api::Engine.root + "spec/fixtures" + filename).path, 'image/jpg', false)
    end



    render_views

    let!(:product) { create(:product) }
    let!(:attributes) { [:id, :position, :attachment_content_type,
                         :attachment_file_name, :type, :attachment_updated_at, :alt] }

    context "as an admin" do
      let!(:current_api_user) do
        role = create :role, name: 'admin'
        user = create :user, spree_roles: [role]
        allow(Spree.user_class).to receive(:find_by).with(hash_including(:spree_api_key)) { current_api_user }
        user
      end

      it "can learn how to create a new product_file" do
        api_get :new, product_id: product.id
        expect(json_response["attributes"]).to eq(attributes.map(&:to_s))
        expect(json_response["required_attributes"]).to be_empty
      end

      it "can upload a new product_file for a product" do
        expect do
          api_post :create,
                   :product_file => { :attachment => upload_product_file('thinking-cat.jpg'),
                               :viewable_type => 'Spree::Product',
                               :viewable_id => product.to_param  },
                   :product_id => product.id
          expect(response.status).to eq(201)
          attributes.each{|attribute| expect(json_response.keys).to include(attribute.to_s) }
        end.to change(ProductFile, :count).by(1)
      end

      it "can't upload a new product_file for a product without attachment" do
        api_post :create,
                 product_file: { viewable_type: 'Spree::Product',
                          viewable_id: product.to_param
                        },
                 product_id: product.id
        expect(response.status).to eq(422)
      end

      context "working with an existing product_file" do
        let!(:product_product_file) { product.product_files.create!(:attachment => upload_product_file('thinking-cat.jpg')) }

        it "can get a single product product_file" do
          api_get :show, :id => product_product_file.id, :product_id => product.id
          expect(response.status).to eq(200)
          attributes.each{|attribute| expect(json_response.keys).to include(attribute.to_s) }
        end

        it "can get a single product product_file" do
          api_get :show, :id => product_product_file.id, :product_id => product.id
          expect(response.status).to eq(200)
          attributes.each{|attribute| expect(json_response.keys).to include(attribute.to_s) }
        end

        it "can get a list of product product_files" do
          api_get :index, :product_id => product.id
          expect(response.status).to eq(200)
          expect(json_response).to have_key("product_files")
          attributes.each{|attribute| expect(json_response["product_files"].first.keys).to include(attribute.to_s) }
        end

        it "can get a list of product product_files" do
          api_get :index, :product_id => product.id
          expect(response.status).to eq(200)
          expect(json_response).to have_key("product_files")
          attributes.each{|attribute| expect(json_response["product_files"].first.keys).to include(attribute.to_s) }
        end

        it "can update product_file data" do
          expect(product_product_file.position).to eq(1)
          api_post :update, :product_file => { :position => 2 }, :id => product_product_file.id, :product_id => product.id
          expect(response.status).to eq(200)
          attributes.each{|attribute| expect(json_response.keys).to include(attribute.to_s) }
          expect(product_product_file.reload.position).to eq(2)
        end

        it "can't update a product_file without attachment" do
          api_post :update,
                   product_file: { attachment: nil },
                   id: product_product_file.id, product_id: product.id
          expect(response.status).to eq(422)
        end

        it "can delete an product_file" do
          api_delete :destroy, :id => product_product_file.id, :product_id => product.id
          expect(response.status).to eq(204)
          expect { product_product_file.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

  end
end
