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
    
   # p videos

    def return_band(str)
        splitted = str.split('-')
        band = splitted[0]
        band.to_s
    end
    
    def return_song(str)
        splitted = str.split('-')
        song = splitted[1]
        song.to_s
    end 
        
    def return_category(str)
        Category.all.each do |category|
            if category == str
                return category.id
            else 
                 nil #no category entered
            end 
        end
    end
                
    def get_image(url)
       image = URI.parse(url)unless url.blank?
    end
         
   # Loop through each of the elements in the 'result' Array & print some of their attributes.
     videos.each do|video|
       #unless Video.where(:title => return_song(video['title']).present?
            Video.create!({
                title: return_song(video['title']),
                band:  return_band(video['title']),
                blurb: video['description'],
                key:   video['key'],
                image: get_image(video['custom']['poster']),
                category_id:return_category(video['custom']['category']) 
               })                    
    end
        
    puts "Publishing Finished!\n\n"

    end
  
end