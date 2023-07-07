class AddNumberToParagraphs < ActiveRecord::Migration[7.0]
  def change
    add_column :paragraphs, :number, :integer
  end
end
