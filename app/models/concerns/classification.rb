module Classification
  extend ActiveSupport::Concern

  included do
    enum classification: { fictional: 0, factual: 1 }
  end
end