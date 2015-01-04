require 'digest/md5'

Paperclip.interpolates :path do |attachment, style|
  path_album = Album.find_by_id(attachment.instance.album_id)
  return "#{path_album.id}_#{path_album.directory_strings}"
end

