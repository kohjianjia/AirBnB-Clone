# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Seed Users
user = {}
user['password'] = 'asdf'
# user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do 
    user['name'] = Faker::Name.name 
    user['email'] = Faker::Internet.email
    user['gender'] = ["male", "female", "other"].sample

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['title'] = Faker::App.name
    listing['home_type'] = ["Apartment", "House", "Bed and Breakfast", "Other"].sample
    listing['room_type'] = ["Entire place", "Private room", "Shared room"].sample

    # # listing['room_number'] = rand(0..5)
    # # listing['bed_number'] = rand(1..6)
    listing['guest_number'] = rand(1..10)

    # listing['country'] = Faker::Address.country
    # listing['state'] = Faker::Address.state
    listing['city'] = Faker::Address.city
    listing['address'] = Faker::Address.full_address

    listing['pricing'] = rand(80..1000)
    listing['summary'] = Faker::Hipster.sentences
    listing['description'] = Faker::Hipster.paragraphs

    listing['amenity'] = ["Self check-in", "Pool", "Gym", "Kitchen", "Washer", "Dryer", "Dishwasher", "Elevator", "Buzzer", "Doorman", "Game console", "Pets allowed", "Heating", "Air conditioning", "Wifi", "TV", "Bathroom essentials", "Bedroom comforts", "Coffee maker", "Smoke detector", "Free parking on premises"].sample(5)

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end