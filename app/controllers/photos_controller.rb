class PhotosController < ApplicationController
  def index
	@photos = Photo.all
  end

  def create
    photo = Photo.new(:uploaded_file => params[:Filedata], :album_id => params[:aid])
    if photo.save
	  @album = Album.find(params[:aid])
	  com = "zip "
	  @album.photos.each do |photok|
	    com += "public/system/pict_share/1/photos/"
		com += "#{photok.id}"
	    #`echo #{photok.id} >> /tmp/photo_make`
	    com += "/original/#{photok.photo.original_filename} "
      end
	  @album.increment_revision
	  @album.save
	  com += " #{@album.id}_#{@album.name}_#{@album.revision}.zip"
	  `echo #{com} >> /tmp/album_job_queue/#{Time.now.strftime("%m%d%H%M")}_#{@album.id}_queue`
      render :json => {"status" => "OK"}
    else
      render :json => {"status" => "NG"}
    end
#	redirect_to album_path(:aid)
  end
end
