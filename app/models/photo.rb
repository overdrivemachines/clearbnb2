# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  caption    :string
#  listing_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Photo < ApplicationRecord
  belongs_to :listing
  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :host_listings_thumb, resize_to_limit: [320, 320]
  end

  validates :caption, presence: true
end
