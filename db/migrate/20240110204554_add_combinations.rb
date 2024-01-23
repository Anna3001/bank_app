class AddCombinations < ActiveRecord::Migration[7.0]
  def change
    create_table :combinations do |t|
      t.text :combination
      t.text :positions

      t.timestamps
    end
  end
end
