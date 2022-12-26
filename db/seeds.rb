# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.find_by(email: "b@b.com")

if user.nil?
  user = User.new(email: "b@b.com", password: "manager", password_confirmation: "manager")
  user.skip_confirmation!
  user.save!
end

10.times do
  # Create listing
  listing =
    user.listings.create(
      title: ("House " + Faker::Science.modifier + " " + Faker::Science.element),
      about: Faker::Quote.jack_handey,
      max_guests: rand(2...10),
      address_line1: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      postal_code: Faker::Address.zip_code(state_abbreviation: "CA"),
      country: "United States",
      status: Listing.statuses.to_a.sample[0],
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
    )
  # Each listing has 1 to 4 rooms
  rand(1...4).times do
    # Create room
    room = listing.rooms.create(room_type: rand(0...3))

    # Each room has 1 to 3 beds
    rand(1...3).times { room.beds.create(bed_size: rand(0...5)) }
  end
end
