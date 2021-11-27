class CreateEventTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :event_types do |t|
      t.string :image_url
      t.string :name

      t.timestamps
    end
  end
end
