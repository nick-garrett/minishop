class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.text :line_1, null: false
      t.text :line_2, null: false
      t.text :line_3, null: false
      t.integer :user_id, null: false, unique: true
      t.timestamps
    end
  end
end
