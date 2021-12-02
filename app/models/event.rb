class Event < ApplicationRecord
  include PgSearch::Model
  attr_accessor :image
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  belongs_to :event_type
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_one :chatroom, dependent: :destroy
  validates :title, :number_of_participants, :languages, :address, :date, presence: true
  validates :description, length: { maximum: 150 }, presence: true
  has_one_attached :photo

  pg_search_scope :search_by_address_and_date, against: [:address, :date],
    using: {
    tsearch: { prefix: true }
    }

  pg_search_scope :search_by_date, against: :date,
     using: {
    tsearch: { prefix: true }
    }
end
