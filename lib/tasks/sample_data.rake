namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
	admin.toggle!(:admin)
#    99.times do |n|
#      name  = Faker::Name.name
#      email = "example-#{n+1}@railstutorial.org"
#      password  = "password"
#      User.create!(name: name,
#                   email: email,
#                   password: password,
#                   password_confirmation: password)
#    end
#
#	users = User.all(limit: 6)
#	2.times do
#	  name = "test name"
#	  content = "test content"
#	  password = "pass"
#	  ncc = rand(4)
#	  ds = "testdirectorystrings123980"
#	  users.each { |user| user.albums.create!(name: name, content: content, password: password, password_confirmation: password, ncc: ncc, directory_strings: ds ) }
#	end
  end
end
