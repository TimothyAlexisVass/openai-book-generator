class Paragraph < ApplicationRecord
  belongs_to :section

  validates :number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
