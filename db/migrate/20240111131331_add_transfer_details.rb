class AddTransferDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :title, :string
    add_column :transfers, :address, :string
    add_column :transfers, :name, :string
  end
end
