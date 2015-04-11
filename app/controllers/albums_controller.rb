# -*- coding: utf-8 -*-
class AlbumsController < ApplicationController
  before_action :signed_in_user, only: [:index, :create, :destroy, :edit]
  # GET /albums
  # GET /albums.json
  def index
#    @albums = Album.all
    @albums = Album.paginate(page: params[:page], :per_page => 10)
#    @tmp = current_album

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    if @album.ncc.nil?
        redirect_to album_signin_path, notice: "Something is wrong with your album(ncc unset)"
    # albumが見れない条件
    # 1. albumのnccが2以上であり、かつ2., 3., 4.のどれかにマッチ
    # 2. ログイン(ユーザ：アルバム)していない
    # 3. ログインしていてもアルバムを保持しているユーザではない
    # 4. ログインしていても該当アルバムに関してログインしていない
    elsif @album.ncc <= 1 ||
          ( @album.ncc >= 2 &&
          ( (!current_user.nil? && (@album.user_id == current_user.id || current_user.id == 1)) ||
            (!current_album.nil? && @album.id == current_album.id )) )
#        @tmp = current_album

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @album }
        end
    else
        redirect_to album_signin_path, notice: "Please sign in."
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
      # albumを保持しているユーザもしくはadminユーザのみ編集可能
    if !(!current_user.nil? && (current_user.id == @album.user_id || current_user.admin == true))
      redirect_to signin_path
    end
  end

  # POST /albums
  # POST /albums.json
  def create
#    @album = Album.new(params[:album])
    @album = current_user.albums.build(album_params)
    @album.revision = 0

    respond_to do |format|
      if @album.save
        sign_album_in @album
        "album save success"
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        puts "album save fail"
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])
    `echo album update #{@album.id} , #{@album.password} >> /tmp/debuglog`
    respond_to do |format|
      if @album.update_attributes!(album_params)
        `echo attributes ok #{@album.id} , #{@album.password} >> /tmp/debuglog`
        @album.password = "password"
        @album.password_confirmation = "password"
        update_zip(@album.id)
        sign_album_in @album
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        `echo attributes not ok #{@album.id} , #{@album.password} >> /tmp/debuglog`
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /add_photos/2
  def add_photos

    @album = Album.find(params[:id])
    if (@album.ncc == 0 ||
       ( !current_user.nil? && @album.user_id == current_user.id ) ||
       ( !current_album.nil? && @album.id == current_album.id ) )

      files = params[:files]
      i = 0
      files.size.times do
        photo = Photo.new(:photo => files[i], :album_id => @album.id)
        if photo.save!
  	      `echo photo save success >> /tmp/debuglog`
        else
  	      `echo photo save fail >> /tmp/debuglog`
        end
        i += 1
      end

      update_zip(@album.id)
      render :js => "window.location = '/albums/#{@album.id}'"
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end

  # update zip file
  # send unix command to resque
  def update_zip(album_id)

    @album = Album.find(album_id)
    rmzip_command = "rm /home/satoshi/pict_share/public/system/pict_share/zips/#{@album.id}_#{@album.directory_strings}.zip"
    zip_command = "/usr/bin/zip -j "
    zip_command += " /home/satoshi/pict_share/public/system/pict_share/zips/#{@album.id}_#{@album.directory_strings}.zip "
    @album.photos.each do |photok|
      zip_command += "/home/satoshi/pict_share/public/system/pict_share/"
      zip_command += "#{@album.id}_#{@album.directory_strings}/photos/"
      zip_command += "#{photok.id}"
      zip_command += "/original/#{photok.id}_#{photok.photo.original_filename} "
    end
    Resque.enqueue(Archive, rmzip_command)
    Resque.enqueue(Archive, zip_command)
  end

  def album_params
    params.require(:album).permit(:name, :content, :photos_attributes, :uploaded_file, :revision, :password, :password_confirmation, :ncc, :directory_strings)
  end
end
