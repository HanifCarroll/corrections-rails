class Post < ApplicationRecord
  belongs_to :user
  has_many :corrections, dependent: :destroy
  has_many :post_sentences, dependent: :destroy
end
