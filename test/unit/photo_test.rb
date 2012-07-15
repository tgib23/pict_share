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

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
