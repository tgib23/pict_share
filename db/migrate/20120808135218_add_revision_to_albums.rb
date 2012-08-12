class AddRevisionToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :revision, :integer

  end
end
