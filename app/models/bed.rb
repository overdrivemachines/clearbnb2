# == Schema Information
#
# Table name: beds
#
#  id         :bigint           not null, primary key
#  room_id    :bigint           not null
#  bed_size   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bed < ApplicationRecord
  belongs_to :room
end
