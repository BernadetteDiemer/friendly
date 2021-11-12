class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one :chatroom, dependent: :destroy
  validates :title, :description, :number_of_participants, :address, :date, presence: true
  has_one_attached :photo
end
