class AddDirstringsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :directory_strings, :string

  end
end
