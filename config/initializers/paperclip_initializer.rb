require 'digest/md5'

Paperclip.interpolates :path do |attachment, style|
  path_album = Album.find_by_id(attachment.instance.album_id)
  return "#{path_album._name}_#{Digest::MD5.hexdigest(path_album.remember_a_token)}"
end

