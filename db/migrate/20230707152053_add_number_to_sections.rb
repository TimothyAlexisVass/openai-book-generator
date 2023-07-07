class AddNumberToSections < ActiveRecord::Migration[7.0]
  def change
    add_column :sections, :number, :integer
  end
end
