class Spree::ProductFile < Spree::Asset
  # attr_accessible :alt, :attachment, :position, :viewable_type, :viewable_id

  has_attached_file :attachment,
                      :url => '/:class/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/:class/:id/:style/:basename.:extension'

  do_not_validate_attachment_file_type :attachment

  def display_name
    alt.blank? ? attachment_file_name : alt
  end


  # validate :no_attachment_errors

  # has_attached_file :attachment,
  #                   styles: { mini: '48x48>', small: '100x100>', product: '240x240>', large: '600x600>' },
  #                   default_style: :product,
  #                   url: '/spree/products/:id/:style/:basename.:extension',
  #                   path: ':rails_root/public/spree/products/:id/:style/:basename.:extension',
  #                   convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment :attachment, presence: true
  #   :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }


  # # if there are errors from the plugin, then add a more meaningful message
  # def no_attachment_errors
  #   unless attachment.errors.empty?
  #     # uncomment this to get rid of the less-than-useful interim messages
  #     # errors.clear
  #     errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
  #     false
  #   end
  # end

end
