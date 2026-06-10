class AddAuthorAndCategoryToBook < ActiveRecord::Migration[8.1]
  def change
      add_reference :books, :author, foreign_key: { to_table: :book_authors }
      add_reference :books, :category, foreign_key: { to_table: :book_categories }
  end
end
