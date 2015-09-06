namespace :user do
    desc " Fill database with sample user data"
    task populate: :environment do
     
    	30.times do |n|
    		puts"[DEBUG] creating user #{n+1} of 100"
    		name = Faker::Name.name
            username = Faker::Internet.user_name(%w(_))
            avatar = File.open(Dir.glob(File.join(Rails.root, 'sampleavatar','*')).sample)
    		email ="user-#{n+1}@example.com"
    		password ="password"
            location =Faker::Address.city
            bio =Faker::Lorem.paragraph
    		User.create!( name: name,
    			          email: email,
                          avatar: avatar,
                          username: username,
    			          password: password,
    			          password_confirmation: password,
                          bio: bio,
                          location:location
                         )
        end
   end
end
 








namespace :category do
    desc "populate Database"
    task populate: :environment do

    video_list = [
      [ "Deutschland", 81831000 ],
      [ "Frankreich", 65447374 ],
      [ "Belgien", 10839905 ],
      [ "Niederlande", 16680000 ]
    ]

        video_list.each do |video|
          Country.create( :name => country[0], :population => country[1] )
        end
               
    end
   
end