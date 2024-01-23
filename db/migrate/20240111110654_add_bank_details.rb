class AddBankDetails < ActiveRecord::Migration[7.0]
  add_column :users, :money, :integer, default: 10000
  add_column :users, :account_number, :string
  add_column :users, :id_number, :string
end
