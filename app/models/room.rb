# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  listing_id :bigint           not null
#  room_type  :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  belongs_to :listing
end
