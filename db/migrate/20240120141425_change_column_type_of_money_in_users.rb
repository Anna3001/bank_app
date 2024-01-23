class ChangeColumnTypeOfMoneyInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :money, :decimal, precision: 10, scale: 2, default: 10000, null: false
  end
end
