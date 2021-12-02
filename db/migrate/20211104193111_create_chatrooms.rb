class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.references :event, null: false, foreign_key: true
<<<<<<< HEAD

=======
>>>>>>> master
      t.timestamps
    end
  end
end
