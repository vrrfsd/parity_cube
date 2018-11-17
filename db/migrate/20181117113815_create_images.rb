class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :album_id
      t.string :pic
      t.string :tag_line

      t.timestamps
    end
  end
end
