class AlbumSessionsController < ApplicationController

  def new
  end

  def create
    album = Album.where(id: params[:album_session][:id]).first
	if album && album.authenticate(params[:album_session][:password])
	  sign_album_in album
	  redirect_to album
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
