class Chapter < ApplicationRecord
  belongs_to :book
  has_many :sections

  validates :number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
end
