# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require "json"
require "rest-client"
require "nokogiri"
require "open-uri"
require 'uri'
require 'net/http'

puts "Wiping existing data..."
Notification.destroy_all
# Vote.delete_all # If you have votes and want to clear them
# UserGroup.delete_all # If you have user_groups and want to clear them
# Calendar.delete_all # If you have calendars and want to clear them
Event.destroy_all
Adventure.destroy_all
Group.destroy_all
User.destroy_all
puts "Existing data wiped."

# 1) A test user
user = User.find_or_create_by!(email: 'user@username.com') do |u|
  u.password = 'password'
  u.username = 'testuser'
end
puts "User created/found: #{user.email}"

user2 = User.find_or_create_by!(email: 'user2@username.com') do |u|
  u.password = 'password'
  u.username = 'testuser2'
end
puts "User created/found: #{user2.email}"

# 2) Two groups
group1 = Group.find_or_create_by!(name: 'Cyberpunk Skyline Group', image_url: "https://img.freepik.com/premium-photo/fashionable-cyberpunk-crew-people-street-night-city-future-cyberpunk-city_250484-1473.jpg")
group1.user_groups.create(user: user)
group1.user_groups.create(user: user2)
group2 = Group.find_or_create_by!(name: 'Synthwave Circle Group', image_url: "https://img.freepik.com/premium-photo/retro-disco-ball-background-with-sparkling-mirrored-disco-ball_1282204-1409.jpg")
group2.user_groups.create(user: user)
group2.user_groups.create(user: user2)
puts "Groups created/found: #{group1.name}, #{group2.name}"

# 3) Create placeholder Events first (since Adventure needs an event_id)
# event1_placeholder = Event.find_or_create_by!(name: 'Event Placeholder for Adventure One', group: group1, user: user) do |e|
#   e.description = 'Initial placeholder for Adventure One'
#   e.location    = 'Testville'
#   e.start_time  = 1.day.from_now
#   e.end_time    = 1.day.from_now + 2.hours
#   e.image_url   = 'https://placehold.co/400'
#   e.category    = 'art'
#   e.price       = 0
#   e.status      = 'voting_open'
# end

# event2_placeholder = Event.find_or_create_by!(name: 'Event Placeholder for Adventure Two', group: group2, user: user) do |e|
#   e.description = 'Initial placeholder for Adventure Two'
#   e.location    = 'Example City'
#   e.start_time  = 2.days.from_now
#   e.end_time    = 2.days.from_now + 3.hours
#   e.image_url   = 'https://placehold.co/400'
#   e.category    = 'music'
#   e.price       = 5
#   e.status      = 'voting_open'
# end
# puts "Placeholder events created/found."

# 4) Create Adventures, linking them to the placeholder Events
# adv1 = Adventure.find_or_create_by!(name: 'Adventure One', event: event1_placeholder) do |adv|
#   adv.description = 'Explore the first test group via Event One'
#   adv.location    = event1_placeholder.location # Match event's location
#   adv.image_url   = 'https://placehold.co/400'
# end

# adv2 = Adventure.find_or_create_by!(name: 'Adventure Two', event: event2_placeholder) do |adv|
#   adv.description = 'Explore the second test group via Event Two'
#   adv.location    = event2_placeholder.location # Match event's location
#   adv.image_url   = 'https://placehold.co/400'
# end
# puts "Adventures created/found: #{adv1.name}, #{adv2.name}"

# Seeding adventures using API
# url = URI("https://tripadvisor-com1.p.rapidapi.com")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["x-rapidapi-key"] = 'a2ee7cbe6cmsh6b6ce0aff2c3b9cp1236f9jsnce68495edd76'
# request["x-rapidapi-host"] = 'tripadvisor-com1.p.rapidapi.com'

# response = http.request(request)
# puts response.read_body

# Seed to insert 10 posts in the database fetched from the API.
# 10.times do
#   adventure = Adventure.new(
#     name: JSON.parse(RestClient.get(""))["name"],
#     description: JSON.parse(RestClient.get(""))["description"],
#     location: JSON.parse(RestClient.get(""))["location"],
#     image_url: JSON.parse(RestClient.get(""))["image_url"]
#   )
#   adventure.save!
# end

# 5) Update the placeholder Events with their respective Adventure IDs and final details
# event1_placeholder.update!(
#   adventure: adv1,
#   name: 'Event One for Adventure One',
#   description: 'First event for Adventure One'
# )

# event2_placeholder.update!(
#   adventure: adv2,
#   name: 'Event Two for Adventure Two',
#   description: 'First event for Adventure Two'
# )
# puts "Events updated with adventure associations."

puts "Seeding complete! 2 users, 2 groups."
