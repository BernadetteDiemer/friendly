class AddEventTypeToEvent < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :event_type, foreign_key: true
  end
end
