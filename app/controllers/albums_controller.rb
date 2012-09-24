class AlbumsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :edit]
  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
	@tmp = current_album

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
		@tmp = current_album

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
	@album = current_user.albums.build(params[:album])
	@album.revision = 0

    respond_to do |format|
      if @album.save
	    sign_album_in @album
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
		`touch /tmp/album_make`
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
	    sign_album_in @album
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
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
end
