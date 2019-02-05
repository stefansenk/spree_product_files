class Spree::ProductFile < Spree::Asset
  validate :check_attachment_presence

  has_one_attached :attachment

  def check_attachment_presence
    unless attachment.attached?
      attachment.purge
      errors.add(:attachment, :attachment_must_be_present)
    end
  end

  include Rails.application.routes.url_helpers

  def display_name
    alt.blank? ? attachment.filename : alt
  end

end
