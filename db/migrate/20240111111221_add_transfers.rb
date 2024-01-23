class AddTransfers < ActiveRecord::Migration[7.0]
  create_table :transfers do |t|
    t.text :sender_account_numberar
    t.text :receiver_account_number
    t.integer :amount
    t.timestamps
  end
end
