class DropExtraBookTables < ActiveRecord::Migration[8.1]
  def change
    remove_reference :books, :category
    remove_reference :books, :author
    drop_table :book_categories
    drop_table :book_authors

    add_column :books, :category, :integer, default: 0
    add_column :books, :author, :string
  end
end
