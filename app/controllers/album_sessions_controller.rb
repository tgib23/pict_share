class AlbumSessionsController < ApplicationController

  def new
  end

  def create
    album = Album.find_by_id(params[:album_session][:id])
	if album && album.authenticate(params[:album_session][:password])
	  sign_album_in album
	  redirect_back_or album
	else
	  flash[:error] = 'Invalid id/password combination'
	  render 'new'
	end
  end

  def destroy
    sign_album_out
	redirect_to albums_url
  end
end
