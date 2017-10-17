class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.text :line_1
      t.text :line_2
      t.text :line_3
      t.timestamps
    end
  end
end
