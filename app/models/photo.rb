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
  belongs_to :album, :polymorphic => true
  has_attached_file :photo,
	:styles => {
	   :large => "680x800",
     :thumb=> "100x100#", },
  :convert_options => { :all => '-auto-orient' },
	:hash_secret => "longSecretString",
	:url => "/system/pict_share/:path/:attachment/:id/:style/:id_:basename.:extension"
#    :path => ":rails_root/public/system/pict_share/:attachment/:id/:style/:hash.:extension" ## attachementがphoto, idが勝手につく
#    :path => ":rails_root/public/system/pict_share/:attachment/:id/:style/:basename.:extension" ## attachementがphoto, idが勝手につく
	validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 20.megabytes
#	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/JPG'] ## うまく動かない
# this add_album branch
#	validates :album_id, presence: true
  def uploaded_file=(file_data)
    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
    self.photo = file_data
  end
end
