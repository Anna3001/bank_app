class AddCardNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :card_number, :string
  end
end
