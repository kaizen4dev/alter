class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.string :picture_url
      t.string :title
      t.integer :all_chapters
      t.integer :read_chapters

      t.timestamps
    end
  end
end
