# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html
    require 'uri' 
    require 'open-uri'
    # https://github.com/flori/json
    require 'json'
    # http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
    require 'pp'
    require 'digest'

namespace :site do
    desc "Sync, pulled videos from cdn and published "
    task  publish: :environment do
         
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
    
    #p videos

        
     def songinfo(str, kind)
         arry = str.split('-')
        if kind == "title"
           title = arry[0]
           title.downcase.strip
        else
           song = arry[1] 
           if song == nil
              song = "missing"
           else
               song.downcase.strip
           end
        end
    end
            
    def get_category(str)
        unless str.blank?
        Category.all.each do |category|
           if str == category.name
               category_id = category.id
               category_id
          end      
        end
      end
        category_id = nil 
    end
                
    def get_image(url)
       image = URI.parse(url)unless url.blank?
    end  
            
   # Loop through each of the elements in the 'result' Array & print some of their attributes.
     videos.each do|video|
       #unless Video.where(:title => return_song(video['title']).present?
            Video.create!({
                title: songinfo(video['title'],"title"),
                band:  songinfo(video['title'],"song"),
                blurb: video['description'],
                key:   video['key'],
                image: get_image(video['custom']['poster']),
                #category_id: get_category(video['custom']['category']),
                poster: video['custom']['poster']
               })                    
    end
      
    sleep(2)
    puts "Checking missing video information"
            Video.where(title: "").update_all(title: "None")
            Video.where(band: "").update_all(band: "None")
            Video.where(blurb: "").update_all(blurb: "sometimes knowing the truth hurts and deal with it cause the biggest pain")
    puts "Missing video information fixed"
    sleep(2)
                
    puts "Publishing Finished!\n\n"
    
    end 
end