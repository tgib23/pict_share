require 'mime/types'
class Photo < ActiveRecord::Base
  has_attached_file :photo,
#    :path => ":rails_root/public/system/:attachment/:id.:extension", ## attachementがphoto, idが勝手につく
#    :url => "/system/:attachment/:id.:extension",
	:styles => {
	   :large => "800x800>", 
       :thumb=> "100x100#",
       :small  => "400x400>" }
	validates_attachment_presence :photo 
	validates_attachment_size :photo, :less_than => 2.megabytes  
#	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] ## うまく動かない

  def uploaded_file=(file_data)
    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
    self.photo = file_data
  end
end
