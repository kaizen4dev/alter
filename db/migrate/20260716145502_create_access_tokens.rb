class CreateAccessTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :access_tokens do |t|
      t.timestamps
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :digest, null: false
      t.boolean :revoked, null: false, default: false
    end
  end
end
