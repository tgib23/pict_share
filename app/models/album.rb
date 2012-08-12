# == Schema Information
#
# Table name: albums
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  content    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

require 'mime/types'
class Album < ActiveRecord::Base
	attr_accessible :name, :content, :photos_attributes, :uploaded_file, :revision
	belongs_to :user
	validates :user_id, presence: true
	has_many :photos
	accepts_nested_attributes_for :photos, :allow_destroy => true
	
  def increment_revision
    tmp = self.revision.to_i + 1
	self.revision = tmp
  end

#  	has_attached_file :photo,
#  	  :styles => {
#  	     :large => "800x800>", 
#  	     :thumb=> "100x100#",
#  	     :small  => "400x400>" },
#  	  :url => "/system/pict_share/album_id/:attachment/:id/:style/:basename.:extension",
#  	  :path => ":rails_root/public/system/pict_share/album_id/:attachment/:id/:style/:basename.:extension" ## attachementがphoto, idが勝手につく
#
#  def uploaded_file=(file_data)
#    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
#    self.photo = file_data
#  end
end
