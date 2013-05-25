class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def create
#    photo = Photo.new(:uploaded_file => params[:Filedata], :album_id => params[:aid])
    `echo create photo #{params[:aid]} toreteru >> /tmp/debuglog`
    photo = Photo.new(:photo => params[:album][:photos_attributes][:photo], :album_id => params[:aid])
#    photo = Photo.new(:album_id => params[:aid])
    if photo.save!
      render :json => {"status" => "OK"}
    else
      render :json => {"status" => "PHOTO SAVE NG"}
    end
#  redirect_to album_path(:aid)
  end

  def destroy
    @delete_photo = Photo.find(params[:id])
  @album = Album.find_by_id(@delete_photo.album_id)
  redirect_pg = 'albums/edit/#{album_id}'
  @delete_photo.destroy
  redirect_to [:edit, @album]
#  redirect_to albums_url
  end
end
