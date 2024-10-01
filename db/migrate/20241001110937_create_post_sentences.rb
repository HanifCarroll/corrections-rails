class CreatePostSentences < ActiveRecord::Migration[8.0]
  def change
    create_table :post_sentences do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.integer :sentence_number
      t.string :text

      t.timestamps
    end
  end
end
