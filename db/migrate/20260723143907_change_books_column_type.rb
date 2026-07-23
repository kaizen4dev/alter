class ChangeBooksColumnType < ActiveRecord::Migration[8.1]
  def change
    change_column :books, :read_chapters, :float
    change_column :books, :all_chapters, :float
  end
end
