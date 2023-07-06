class Book < ApplicationRecord
  include Classification

  belongs_to :subcategory
  belongs_to :category
  has_many :chapters

  validates :title, presence: true
end