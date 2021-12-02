class RemoveNotificationFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :notification, :boolean
  end
end
