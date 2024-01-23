class AddRandomAcc < ActiveRecord::Migration[7.0]
  def change
      add_column :users, :account_no, :integer, :default => (999999..9999999).to_a.sample
      remove_column :users, :account_number

  end
end
