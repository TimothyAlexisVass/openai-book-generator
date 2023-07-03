class Book < ApplicationRecord
  enum book_type: { fiction: 0, factual: 1 }
  
  FICTION_CATEGORIES = %w[fantasy feelgood other].freeze
  FACTUAL_CATEGORIES = %w[science humanities technology arts worldly].freeze

  validates :category, inclusion: { in: FICTION_CATEGORIES, if: :fiction? }
  validates :category, inclusion: { in: FACTUAL_CATEGORIES, if: :factual? }

  def self.fiction_categories
    FICTION_CATEGORIES
  end

  def self.factual_categories
    FACTUAL_CATEGORIES
  end

  has_many :chapters
end
