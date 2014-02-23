class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.text :about, null: false
      t.string :likes
      t.string :dislikes
      t.float :lat, null: true
      t.float :lon, null: true

      t.timestamps
    end
  end
end
