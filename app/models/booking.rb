class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reviews, dependent: :destroy

  enum status: { pending: 0, accepted: 1, declined: 2 }
end
