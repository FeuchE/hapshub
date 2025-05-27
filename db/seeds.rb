# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Wiping existing data..."
Notification.delete_all
# Vote.delete_all # If you have votes and want to clear them
# UserGroup.delete_all # If you have user_groups and want to clear them
# Calendar.delete_all # If you have calendars and want to clear them
Adventure.delete_all
Event.delete_all
Group.delete_all
User.delete_all
puts "Existing data wiped."

# 1) A test user
user = User.find_or_create_by!(email: 'user@username.com') do |u|
  u.password = 'password'
  u.username = 'testuser'
end
puts "User created/found: #{user.email}"

# 2) Two groups
group1 = Group.find_or_create_by!(name: 'First Test Group')
group2 = Group.find_or_create_by!(name: 'Second Test Group')
puts "Groups created/found: #{group1.name}, #{group2.name}"

# 3) Create placeholder Events first (since Adventure needs an event_id)
event1_placeholder = Event.find_or_create_by!(name: 'Event Placeholder for Adventure One', group: group1, user: user) do |e|
  e.description = 'Initial placeholder for Adventure One'
  e.location    = 'Testville'
  e.start_time  = 1.day.from_now
  e.end_time    = 1.day.from_now + 2.hours
  e.image_url   = 'https://placehold.co/400'
  e.category    = 'art'
  e.price       = 0
  e.status      = 'voting_open'
end

event2_placeholder = Event.find_or_create_by!(name: 'Event Placeholder for Adventure Two', group: group2, user: user) do |e|
  e.description = 'Initial placeholder for Adventure Two'
  e.location    = 'Example City'
  e.start_time  = 2.days.from_now
  e.end_time    = 2.days.from_now + 3.hours
  e.image_url   = 'https://placehold.co/400'
  e.category    = 'music'
  e.price       = 5
  e.status      = 'voting_open'
end
puts "Placeholder events created/found."

# 4) Create Adventures, linking them to the placeholder Events
adv1 = Adventure.find_or_create_by!(name: 'Adventure One', event: event1_placeholder) do |adv|
  adv.description = 'Explore the first test group via Event One'
  adv.location    = event1_placeholder.location # Match event's location
  adv.image_url   = 'https://placehold.co/400'
end

adv2 = Adventure.find_or_create_by!(name: 'Adventure Two', event: event2_placeholder) do |adv|
  adv.description = 'Explore the second test group via Event Two'
  adv.location    = event2_placeholder.location # Match event's location
  adv.image_url   = 'https://placehold.co/400'
end
puts "Adventures created/found: #{adv1.name}, #{adv2.name}"

# 5) Update the placeholder Events with their respective Adventure IDs and final details
event1_placeholder.update!(
  adventure: adv1,
  name: 'Event One for Adventure One',
  description: 'First event for Adventure One'
)

event2_placeholder.update!(
  adventure: adv2,
  name: 'Event Two for Adventure Two',
  description: 'First event for Adventure Two'
)
puts "Events updated with adventure associations."

puts "Seeding complete! 1 user, 2 groups, 2 events, 2 adventures created and linked."
