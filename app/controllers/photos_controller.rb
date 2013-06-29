class PhotosController < ApplicationController
  def destroy
    @delete_photo = Photo.find(params[:id])
  @album = Album.find_by_id(@delete_photo.album_id)
  redirect_pg = 'albums/edit/#{album_id}'
  @delete_photo.destroy
  redirect_to [:edit, @album]
#  redirect_to albums_url
  end
end
