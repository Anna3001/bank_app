class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.string :email
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
