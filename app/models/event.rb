class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews
  has_one :chatroom
  validates :title, :description, :number_of_participants, :address, :date, presence: true
end
