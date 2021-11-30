require 'date'
require 'faker'

Chatroom.destroy_all
Event.destroy_all
Booking.destroy_all
Review.destroy_all
Chatroom.destroy_all
Message.destroy_all
User.destroy_all


# Users

users = []

puts "Creating users..."

5.times do
  users << user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    about: Faker::Quote.famous_last_words,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 100),
    gender: Faker::Gender.type,
    email: Faker::Internet.email,
    password: "123456"
  )
  puts "#{user.first_name} #{user.last_name}"
end

puts "5 users were created"


# Events

events = []

puts "Planning events... "

5.times do
  events << event = Event.create!(
    title: ["Baking workshop", "Let's go the cinema!", "Starting a bookclub", "Poem Reading", "Späti beers in da house", "Grilling hot dogs on a bonfire", "Going on a hike", "Drinks at my place"].sample,
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

puts "Desiring accepted bookings... "

5.times do
  bookings << booking = Booking.create!(
    status: "accepted",
    message: Faker::Lorem.sentence,
    user: users.sample,
    event: events.sample
  )
  puts "#{booking.user.first_name} booked '#{booking.event.title}'"
end

puts "Desiring all bookings... "

5.times do
  bookings << booking = Booking.create!(
    status: rand(0..2),
    message: Faker::Lorem.sentence,
    user: users.sample,
    event: events.sample
  )
  puts "#{booking.user.first_name} booked '#{booking.event.title}'"
end

puts "10 bookings were achieved"


# Reviews

# only allow users with an accepted booking request for an event to leave reviews
def find_correct_users(invites)
  accepted_bookings = invites.select { |invite| invite.status == "accepted" }
  accepted_users = []

  accepted_bookings.each do |booking|
    accepted_users << booking.user
  end

  return accepted_users
end

reviews = []

puts "Asking for reviews..."
num_of_b = bookings.select { |booking| booking.status == "accepted" }

# there should only be as many reviews as there have been 'accepted' bookings
num_of_b.each do |booking|
  reviews << review = Review.create!(
    rating: rand(1..5),
    comment: Faker::Restaurant.review,
    user: booking.user,
    booking: booking
  )
  puts "#{review.user.first_name} left a review for '#{booking.event.title}'"
end

puts "#{num_of_b.length} reviews were left"

# Chatrooms

# making it so that only events that have accepted bookings will have a chatroom
def finding_events(invites)
  accepted_bookings = invites.select { |invite| invite.status == "accepted" }
  accepted_events = []

  accepted_bookings.each do |booking|
    accepted_events << booking.event
  end

  return accepted_events
end

chatrooms = []

puts "Calibrating chatrooms..."
# there should be as many chatrooms as events with 'accepted' bookings
# and the id of the chosen event should be unique, since one event can only have one chatroom
finding_events(bookings).each do |event|
  chatrooms << chatroom = Chatroom.create!(
    event: event
  )
  puts "Chatroom for '#{chatroom.event.title}' by '#{chatroom.event.user.first_name}' was created"
end

puts "#{finding_events(bookings).length} chatrooms were calibrated"


# Messages

# only people that have an accepted booking for an event can write messages in the event chat
def find_the_chatting_user(messenger)
  found_users = []
  messenger.event.bookings.each do |booking|
    found_users << booking.user
  end
  return found_users
end

puts "Imagining messages..."

10.times do
  chatroom = chatrooms.sample
  user = find_the_chatting_user(chatroom).sample

  Message.create!(
    content: Faker::Quote.most_interesting_man_in_the_world,
    chatroom: chatroom,
    user: user
  )
end

puts "10 messages were imagined"
puts "One of them was this: #{Message.first.content}"
