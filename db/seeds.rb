require 'date'
require 'faker'

User.destroy_all
Event.destroy_all
Booking.destroy_all

users = []
# Users
5.times do
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    about: Faker::Quote.famous_last_words,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 100),
    gender: Faker::Gender.type ,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6)
  )
end

puts "Created 5 users"
# events
events = []
puts events
5.times do
  events << Event.create!(
    title: ["Baking workshop", "Let's go the cinema!", "Start of a bookclub", "Poem Reading", "Spati beers in da house", "Grilling hot dogs on a bonfire"].sample,
    description: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    number_of_participants: rand(1..7),
    date: Faker::Date.between(from: '2021-11-1', to: '2021-12-31'),
    address: Faker::Address.full_address,
    languages: ["english", "french", "german", "italian"].sample,
    user: users.sample
  )
end
puts "5 events were created"

# bookings
bookings = []

5.times do
  bookings << Booking.create!(
    status: rand(0..2),
    message: Faker::Lorem.sentence,
    user: users.sample,
    event: events.sample
  )
end

puts "5 bookings were created"
