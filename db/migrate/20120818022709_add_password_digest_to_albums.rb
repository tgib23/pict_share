class AddPasswordDigestToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :password_digest, :string

  end
end
