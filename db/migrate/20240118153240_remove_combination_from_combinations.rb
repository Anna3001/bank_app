class RemoveCombinationFromCombinations < ActiveRecord::Migration[7.0]
  def change
    remove_column :combinations, :combination, :text
  end
end
