require 'digest/md5'

Paperclip.interpolates :path do |attachment, style|
  path_album = Album.find_by_id(attachment.instance.album_id)
  return "#{path_album._id}_#{path_album._name}_#{path_album._directory_strings}"
end

