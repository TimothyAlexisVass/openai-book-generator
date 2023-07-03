class Book < ApplicationRecord
  enum book_type: { fiction: 0, factual: 1 }
  enum category: { science: 0, humanity: 1, technology: 2, arts: 3, worldly: 4 }

  has_many :chapters
end
