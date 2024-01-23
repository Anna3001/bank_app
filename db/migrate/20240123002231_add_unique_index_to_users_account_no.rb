class AddUniqueIndexToUsersAccountNo < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :account_no, unique: true
  end
end
