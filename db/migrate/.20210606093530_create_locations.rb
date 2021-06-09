class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :location do |t|
      t.string :name
      t.string :image_url
      t.references :planet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
