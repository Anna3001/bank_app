class AddLastUsedCombinationIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_used_combination_id, :integer
  end
end
