class Section < ApplicationRecord
  belongs_to :chapter
  has_many :paragraphs
end
