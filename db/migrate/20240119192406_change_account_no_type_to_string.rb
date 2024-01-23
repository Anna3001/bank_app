class ChangeAccountNoTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :account_no, :string
  end
end
