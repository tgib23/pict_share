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
	attr_accessible :name, :content, :photos_attributes, :uploaded_file, :revision, :password, :password_confirmation, :ncc, :directory_strings
	has_secure_password
	belongs_to :user
	before_save :create_remember_a_token
	validates :user_id, presence: true
	validates :name, presence: true, length: {maximum: 50}
	validates :password, presence: true
	validates :password_confirmation, presence: true
	validates :ncc, presence: true
	validates :directory_strings, presence: true
	has_many :photos, dependent: :destroy
	accepts_nested_attributes_for :photos, :allow_destroy => true
	
  def increment_revision
    tmp = self.revision.to_i + 1
	self.revision = tmp
  end

  private
    def create_remember_a_token
	  self.remember_a_token = SecureRandom.urlsafe_base64
	end

end
