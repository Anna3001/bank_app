class AddHashedCombinationAndSaltToCombinations < ActiveRecord::Migration[7.0]
  def change
    add_column :combinations, :hashed_combination, :string
    add_column :combinations, :salt, :string
  end
end
