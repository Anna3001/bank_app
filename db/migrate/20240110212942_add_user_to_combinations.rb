class AddUserToCombinations < ActiveRecord::Migration[7.0]
  def change
    add_reference :combinations, :user, null: false, foreign_key: true
  end
end
