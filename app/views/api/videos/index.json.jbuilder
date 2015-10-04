json.videos  @videos do |video|  
  json.id      video.id
  json.title   video.title
  json.band    video.band
  json.views   video.views
  json.hearts  video.hearts.count
  json.image   video.image
  
end  