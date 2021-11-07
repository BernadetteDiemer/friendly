require 'date'
require 'faker'

User.destroy_all
Event.destroy_all
Booking.destroy_all
Review.destroy_all
Chatroom.destroy_all
Message.destroy_all

# Users

users = []

puts "Creating users..."

5.times do
  users << user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    about: Faker::Quote.famous_last_words,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 100),
    gender: Faker::Gender.type ,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6)
  )
  puts "#{user.first_name} #{user.last_name}"
end

puts "5 users were created"

# Events

events = []

puts "Creating events... "
5.times do
  events << event = Event.create!(
    title: ["Baking workshop", "Let's go the cinema!", "Start of a bookclub", "Poem Reading", "Späti beers in da house", "Grilling hot dogs on a bonfire"].sample,
    description: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    number_of_participants: rand(1..7),
    date: Faker::Date.between(from: '2021-11-1', to: '2021-12-31'),
    address: Faker::Address.full_address,
    languages: ["english", "french", "german", "italian"].sample,
    user: users.sample
  )
  puts "'#{event.title}' by #{event.user.first_name}"
end

puts "5 events were created"

# Bookings
bookings = []

5.times do
  bookings << booking = Booking.create!(
    status: rand(0..2),
    message: Faker::Lorem.sentence,
    user: users.sample,
    event: events.sample
  )
  puts "#{booking.user.first_name} booked '#{booking.event.title}'"
end

puts "5 bookings were created"

# Reviews

reviews = []

5.times do
  users_with_bookings = users.select(&:bookings)
  users_with_accepted_bookings = users_with_bookings.select { |user| user.bookings.where(status: "accepted") }
  user = users_with_accepted_bookings.sample

  reviews << review = Review.create!(
    rating: rand(1..5),
    comment: Faker::Restaurant.review,
    user: user,
    booking: user.bookings.first
  )
  puts "#{review.user.first_name} left a review for '#{user.bookings.first.event.title}'"
end

puts "5 reviews were created"

# Chatrooms

chatrooms = []

puts "Creating chatrooms..."

2.times do
  # booked_events = events.select(&:bookings)

  chatrooms << chatroom = Chatroom.create!(
    event: booked_events.sample
  )
  puts "Chatroom for '#{chatroom.event.title}' by '#{chatroom.event.user.first_name}' was created"
end

# Messages

puts "Creating messages..."

10.times do
  message = Message.create!(
    content: Faker::Quote.most_interesting_man_in_the_world,
    chatroom: chatroom.sample,
    user: chatroom.event.booking.user
  )
end
