class AddNoncreatorcontrolToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :ncc, :integer

  end
end
