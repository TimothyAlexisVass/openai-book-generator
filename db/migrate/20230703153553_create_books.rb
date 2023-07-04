class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :classification
      t.string :category
      t.string :subcategory
      t.string :title

      t.timestamps
    end
  end
end
