class PhotosController < ApplicationController
  def index
  @photos = Photo.all
  end

  def create
    photo = Photo.new(:uploaded_file => params[:Filedata], :album_id => params[:aid])
    if photo.save
      @album = Album.find(params[:aid])
			rmzip_com = "rm /home/satoshi/rails/pict_share/public/system/pict_share/zips/#{@album.id}_#{@album.name}_#{@album.directory_strings}.zip"
			rmcom_com = "rm /tmp/album_job_queue/*_#{@album.id}_*"
      com = "/usr/bin/zip -j "
      com += " /home/satoshi/rails/pict_share/public/system/pict_share/zips/#{@album.id}_#{@album.name}_#{@album.directory_strings}.zip "
      @album.photos.each do |photok|
        com += "/home/satoshi/rails/pict_share/public/system/pict_share/"
        com += "#{@album.id}_#{@album.name}_#{@album.directory_strings}/photos/"
        com += "#{photok.id}"
        com += "/original/#{photok.photo.original_filename} "
      end
      #@album.save
			`#{rmcom_com}`
			`echo #{rmzip_com} >> /tmp/album_job_queue/#{Time.now.strftime("%m%d%H%M")}_#{@album.id}_queue`
      `echo #{com} >> /tmp/album_job_queue/#{Time.now.strftime("%m%d%H%M")}_#{@album.id}_queue`
      render :json => {"status" => "OK"}
    else
      render :json => {"status" => "NG"}
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
