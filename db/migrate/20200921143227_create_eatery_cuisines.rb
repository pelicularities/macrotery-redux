class CreateEateryCuisines < ActiveRecord::Migration[6.0]
  def change
    create_table :eatery_cuisines do |t|
      t.references :eatery, null: false, foreign_key: true
      t.references :cuisine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
