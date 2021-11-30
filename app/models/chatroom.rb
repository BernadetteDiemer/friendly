class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :event
  validates :event_id, uniqueness: true
end
