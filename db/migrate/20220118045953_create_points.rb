class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.string :payer, null: false
      t.integer :points, null: false
      t.integer :remaining_points, null: false
      t.datetime :timestamp, null: false
    end

    add_index :points, :timestamp
  end
end
