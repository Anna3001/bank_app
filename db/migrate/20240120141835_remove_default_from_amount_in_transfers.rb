class RemoveDefaultFromAmountInTransfers < ActiveRecord::Migration[7.0]
  def change
    change_column :transfers, :amount, :decimal, precision: 10, scale: 2, null: false, default: nil
  end
end
