# == Schema Information
#
# Table name: reservations
#
#  id         :bigint           not null, primary key
#  listing_id :bigint           not null
#  session_id :string
#  guest_id   :bigint           not null
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: "User"

  # pending (default) - when reservation is created
  # booked - when reservation is fully paid
  # cancelled - reservation payment was cancelled
  enum status: { pending: 0, booked: 1, cancelled: 2 }
end
