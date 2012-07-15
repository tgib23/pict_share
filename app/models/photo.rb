# == Schema Information
#
# Table name: photos
#
#  id                 :integer         not null, primary key
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  album_id           :integer
#

require 'mime/types'
class Photo < ActiveRecord::Base
  attr_accessible :album_id, :uploaded_file
  belongs_to :album
  has_attached_file :photo,
	:styles => {
	   :large => "800x800>", 
       :thumb=> "100x100#",
       :small  => "400x400>" },
    :url => "/system/pict_share/1/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/system/pict_share/1/:attachment/:id/:style/:basename.:extension" ## attachementがphoto, idが勝手につく
#	validates_attachment_presence :photo
#	validates_attachment_size :photo, :less_than => 2.megabytes  
#	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] ## うまく動かない
# this add_album branch
#	validates :album_id, presence: true
  def uploaded_file=(file_data)
    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
    self.photo = file_data
  end
end
