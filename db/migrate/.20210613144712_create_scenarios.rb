class CreateScenarios < ActiveRecord::Migration[6.1]
  def change
    create_table :scenarios do |t|
      t.string :text
      t.references :action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
