class AddPassLen < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_length, :integer
  end
end
