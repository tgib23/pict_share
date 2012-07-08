class PhotosController < ApplicationController
  def index
	@photos = Photo.all
  end

  def create
    photo = Photo.new(:uploaded_file => params[:Filedata], :album_id => params[:aid])
#    photo = Photo.new(:uploaded_file => params[:Filedata], :album_id => 1)
#    photo = Photo.new(:uploaded_file => params[:Filedata])
    if photo.save
      render :json => {"status" => "OK"}
    else
      render :json => {"status" => "NG"}
    end
  end
end
