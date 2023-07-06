class AddNumberToChapters < ActiveRecord::Migration[7.0]
  def change
    add_column :chapters, :number, :integer
  end
end
