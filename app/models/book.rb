class Book < ApplicationRecord
  include Classification

  belongs_to :subcategory
  belongs_to :category
  has_many :chapters

  validates :title, :author, presence: true

  def self.fictional_categories
    Category.where(classification: :fictional)
  end

  def self.factual_categories
    Category.where(classification: :factual)
  end
end