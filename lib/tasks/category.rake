namespace :category do
    desc "Create Categories for publications"
    task create: :environment do

    Category.create([
               {name: 'Kompa'},
               {name: 'Kizomba'},
               {name: 'Zouk'},
               {name: 'HipHop Kreyol'},
               {name: 'Roots'}
               ])
               
      
   Type.create([
               {vid_type: 'new'},
               {vid_type: 'hot'},
               {vid_type: 'certified'},
               {vid_type: 'premiere'},
               ])         
               
    end
   
end