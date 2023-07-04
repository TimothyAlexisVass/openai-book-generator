class AddSubcategoryAndCategoryToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :subcategory, null: false, foreign_key: true
    add_reference :books, :category, null: false, foreign_key: true
  end
end
