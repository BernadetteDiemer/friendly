class Event < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_one :chatroom, dependent: :destroy
  validates :title, :description, :number_of_participants, :address, :date, presence: true
  has_one_attached :photo
end
