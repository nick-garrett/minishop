class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.decimal :price, null: false, precision: 10, scale: 2
      t.decimal :usage, null: false, precision: 10, scale: 4
      t.timestamps
    end
  end
end
