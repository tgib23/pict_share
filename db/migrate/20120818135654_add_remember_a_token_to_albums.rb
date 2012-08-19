class AddRememberATokenToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :remember_a_token, :string
	add_index  :albums, :remember_a_token
  end
end
