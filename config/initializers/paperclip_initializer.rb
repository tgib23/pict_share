require 'digest/md5'

Paperclip.interpolates :path do |attachment, style|
  path_album = Album.where(id: attachment.instance.album_id).first
  return "#{path_album.id}_#{path_album.directory_strings}"
end

