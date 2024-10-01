class CorrectionSentence < ApplicationRecord
  belongs_to :correction
  belongs_to :post_sentence
end
