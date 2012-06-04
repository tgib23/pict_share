require 'mime/types'
class Photo < ActiveRecord::Base
  has_attached_file :photo,
    :path => ":rails_root/public/system/:attachment/:id.:extension",
    :url => "/system/:attachment/:id.:extension",
	:styles => {
       :thumb=> "100x100#",
       :small  => "400x400>" }

  def uploaded_file=(file_data)
    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
    self.photo = file_data
  end
end
