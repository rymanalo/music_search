class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.boolean :favorite
      t.integer :user_id

      t.timestamps
    end
  end
end
