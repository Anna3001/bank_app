class ChangeAmountColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :transfers, :amount, :decimal, precision: 10, scale: 2, default: 15000.50, null: false
  end
end
