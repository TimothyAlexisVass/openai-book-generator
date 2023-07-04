class Category < ApplicationRecord
  include Classification

  has_many :subcategories
  has_many :books

  validates :name, presence: true

  def self.formatted_categories
    result = pluck(:classification, :name)
    categories = result.group_by(&:first).transform_values { |values| values.map(&:last) }
  
    categories.transform_values do |names|
      names.each_with_object({}) do |name, hash|
        hash[name] = find_by(name: name).subcategories.pluck(:name)
      end
    end
  end  
end
