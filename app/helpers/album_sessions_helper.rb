module AlbumSessionsHelper
  def sign_album_in(album)
    cookies.permanent[:remember_a_token] = album.remember_a_token
	self.current_album = album
  end

  def signed_album_in?
    !current_album.nil?
  end

  def current_album=(album)
    @current_album = album
  end

  def current_album
    @current_album ||= Album.find_by_remember_a_token(cookies[:remember_a_token])
  end

  def current_album?(album)
    album == current_album
  end

  def sign_album_out
    self.current_album = nil
    #current_album = nil
	cookies.delete(:remember_a_token)
  end

end
