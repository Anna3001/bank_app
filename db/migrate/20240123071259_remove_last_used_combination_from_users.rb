class RemoveLastUsedCombinationFromUsers < ActiveRecord::Migration[7.0]
  def change
    def change
      remove_column :users, :last_used_combination_id, :integer
      remove_column :users, :last_used_combination, :string
    end
  end
end
