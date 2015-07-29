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
    end
   
end