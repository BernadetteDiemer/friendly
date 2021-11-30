class AddNotificationToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :notification, :boolean
  end
end
