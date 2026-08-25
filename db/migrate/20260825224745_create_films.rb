class CreateFilms < ActiveRecord::Migration[8.1]
  def change
    create_table :films do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.integer :category, default: 0
      t.integer :status, default: 0

      t.string :title
      t.integer :all_episodes
      t.integer :seen_episodes, default: 0

      t.timestamps
    end
  end
end
