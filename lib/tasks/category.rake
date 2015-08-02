namespace :category do
    desc "Create Categories for publications"
    task create: :environment do

    Category.create([
               {name: 'Kompa'},
               {name: 'Zouk'},
               {name: 'Kizomba'},
               {name: 'HipHop Kreyol'},
               {name: 'roots'}
               ])
               
      
   Type.create([
               {vid_type: 'new'},
               {vid_type: 'hot'},
               {vid_type: 'certified'},
               {vid_type: 'premiere'},
               ])         
               
    end
   
end