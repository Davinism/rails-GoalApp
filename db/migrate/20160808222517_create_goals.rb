class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :description, null: false
      t.integer :user_id, null: false
      t.string :privacy, null: false
      t.integer :progress, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
