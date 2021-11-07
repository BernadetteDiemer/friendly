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

puts "Planning events... "

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

puts "5 events were planned"


# Bookings

bookings = []

puts "Desiring bookings... "

5.times do
  bookings << booking = Booking.create!(
    status: rand(0..2),
    message: Faker::Lorem.sentence,
    user: users.sample,
    event: events.sample
  )
  puts "#{booking.user.first_name} booked '#{booking.event.title}'"
end

puts "5 bookings were achieved"


# Reviews

# only allow users with an accepted booking request for an event to leave reviews
def find_correct_users(invites)
  accepted_bookings = invites.where(status: "accepted")
  accepted_users = []

  accepted_bookings.each do |booking|
    accepted_users << booking.user
  end

  return accepted_users
end

reviews = []

puts "Asking for reviews..."

5.times do
  correct_users = find_correct_users(bookings)
  user = correct_users.sample

  reviews << review = Review.create!(
    rating: rand(1..5),
    comment: Faker::Restaurant.review,
    user: user,
    booking: user.bookings.first
  )
  puts "#{review.user.first_name} left a review for '#{user.bookings.first.event.title}'"
end

puts "5 reviews were left"

# Chatrooms

# making it so that only events that have accepted bookings will have a chatroom
def finding_events(invites)
  accepted_bookings = invites.where(status: "accepted")
  accepted_events = []

  accepted_bookings.each do |booking|
    accepted_events << booking.event
  end

  return accepted_events
end

chatrooms = []

puts "Calibrating chatrooms..."

2.times do

  chatrooms << chatroom = Chatroom.create!(
    event: finding_events(bookings).sample
  )
  puts "Chatroom for '#{chatroom.event.title}' by '#{chatroom.event.user.first_name}' was created"
end

puts "2 chatrooms were calibrated"


# Messages

puts "Imagining messages..."

10.times do
  # only people that have an accepted booking for an event can write messages in the event chat
  users_with_access = users_with_accepted_bookings.select { |user| user.events.chatrooms.include(chatrooms[0] || chatrooms[1])}

  message = Message.create!(
    content: Faker::Quote.most_interesting_man_in_the_world,
    chatroom: chatrooms.sample,
    user: chatroom.event.booking.user
  )
end

puts "10 messages were imagined"
