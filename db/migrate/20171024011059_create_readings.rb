class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.decimal :usage, null: false, precision: 10, scale: 4
      t.timestamps
    end
  end
end
