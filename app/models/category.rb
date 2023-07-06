class Category < ApplicationRecord
  include Classification

  has_many :subcategories
  has_many :books

  validates :name, presence: true

  def self.formatted_categories
    result = pluck(:id, :classification, :name)
    categories = result.group_by { |(_, classification, _)| classification }
                        .transform_values { |values| values.map { |(_, _, name)| name } }
  
    categories.transform_values do |names|
      names.each_with_object({}).with_index do |((name, _), hash), index|
        category_id = result.find { |(_, _, n)| n == name }[0]
        subcategories = find_by(name: name).subcategories.pluck(:id, :name)
        subcategories_with_ids = subcategories.map { |(subcat_id, subcat_name)| [subcat_id, subcat_name] }
  
        hash[[category_id, name]] = subcategories_with_ids
      end
    end
  end   
end
