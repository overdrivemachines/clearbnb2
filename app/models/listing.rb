# == Schema Information
#
# Table name: listings
#
#  id            :bigint           not null, primary key
#  title         :string           not null
#  about         :text
#  max_guests    :integer          default(2)
#  host_id       :bigint           not null
#  latitude      :string
#  longitude     :string
#  address_line1 :string
#  address_line2 :string
#  city          :string
#  state         :string
#  postal_code   :string
#  country       :string
#  status        :integer          default("draft")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  price         :integer
#  nightly_price :integer
#  cleaning_fee  :integer
#
class Listing < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :rooms
  has_many :photos

  scope :published, -> { where(status: :published) }

  validates :title, presence: true
  validates :max_guests, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :nightly_price, numericality: { greater_than: 0 }
  validates :cleaning_fee, numericality: { greater_than: 0 }
  enum status: { draft: 0, published: 1, archived: 2 }

  # Returns the full address in one line
  def address
    address_line2.blank? ? "#{address_line1} #{city}, #{state}" : "#{address_line1} #{address_line2} #{city}, #{state}"
  end
end
