class CreateScenarioWinnings < ActiveRecord::Migration[6.1]
  def change
    create_table :scenario_winnings do |t|
      t.int :gold
      t.int :health
      t.int :happiness
      t.string :experience
      t.string :int
      t.string :cleanliness
      t.string :int
      t.int :food
      t.references :item, null: false, foreign_key: true
      t.references :item_category, null: false, foreign_key: true
      t.references :scenario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
