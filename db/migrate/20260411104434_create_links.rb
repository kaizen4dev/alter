class CreateLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :links do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
