class Correction < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :correction_sentences, dependent: :destroy
end
