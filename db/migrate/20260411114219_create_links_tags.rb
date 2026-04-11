class CreateLinksTags < ActiveRecord::Migration[8.1]
  def change
    create_table :links_tags, id: false do |t|
      t.belongs_to :tag, null: false, foreign_key: true
      t.belongs_to :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
