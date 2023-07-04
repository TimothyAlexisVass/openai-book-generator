class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :books

  validates :name, presence: true
end