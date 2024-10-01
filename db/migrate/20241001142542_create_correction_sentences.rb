class CreateCorrectionSentences < ActiveRecord::Migration[8.0]
  def change
    create_table :correction_sentences do |t|
      t.belongs_to :correction, null: false, foreign_key: true
      t.belongs_to :post_sentence, null: false, foreign_key: true
      t.string :corrected_text
      t.string :explanation

      t.timestamps
    end
  end
end
