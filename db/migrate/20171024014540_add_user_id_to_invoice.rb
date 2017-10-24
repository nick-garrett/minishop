class AddUserIdToInvoice < ActiveRecord::Migration[5.1]
  def change
    change_table :invoices do |t|
      t.integer :user_id, null: false, default: 1
    end
  end
end
