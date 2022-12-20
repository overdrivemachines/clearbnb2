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
#
class Listing < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :rooms

  validates :title, presence: true
  validates :max_guests, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  enum status: { draft: 0, published: 1, archived: 2 }
end
