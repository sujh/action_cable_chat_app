class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name, limit: 20, null: false
      t.string :desc, limit: 50
      t.boolean :traced, null: false, default: true

      t.timestamps
    end
  end
end
