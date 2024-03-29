# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    # http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html
    require 'uri' 
    require 'open-uri'
    # https://github.com/flori/json
    require 'json'
    # http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
    require 'pp'
    require 'digest'

namespace :cdn do
    desc "Sync, pulled videos from cdn and published "
    task sync: :environment do
         
    # Construct the URL we'll be calling
    request_uri = 'http://api.jwplatform.com/v1/videos/list?'
    url_params = {api_format: "json", api_key: 'JdT4bbux', api_nonce: rand.to_s[2..9], api_timestamp: Time.now.to_i}
    secret ='2zJRn3NtzSq8cLqxGlMnKg8S'
    url_query =URI.encode_www_form(url_params)
    signature = Digest::SHA1.hexdigest(url_query + secret)    
    merged = url_params.merge(api_signature: signature)
    query_str =URI.encode_www_form(merged)
    url = "#{request_uri}"+ query_str
            
        
    # Actually fetch the contents of the remote URL as a String.
    buffer = open(url).read

    # Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
    result = JSON.parse(buffer)
    videos = result['videos']
    
    puts videos

=begin
    def return_title_band(str)
        if Video.keys == "title"
            splitted = str.split('-')
            band = splitted[1]
            band.to_s
        else
            song = splitted[0]
            song.to_s
        end
    end 
      
    def return_category(arr)
        tags = arr.split(',')
        tags.each do |tag|
            if tag ==
    end
          
    def get_image(str)
       
    end

        
    Loop through each of the elements in the 'result' Array & print some of their attributes.
     videos.each do|video|
       #unless Video.exists?(title: return_song(video['title']))
            Video.create!{
                title: return_song(video['title']),
                band:  return_band(video['title']),
                blurb: video['description'],
                key:   video['key'],
                image: get_image(video['title']),
                category: return_category(video['tags'])
                    
    end
=end   
    p result  

        
    puts "Finished!\n\n"
               
    end
   
end