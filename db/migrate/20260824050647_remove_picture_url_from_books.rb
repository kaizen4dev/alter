class RemovePictureUrlFromBooks < ActiveRecord::Migration[8.1]
  def change
    remove_column :books, :picture_url, :string
  end
end
