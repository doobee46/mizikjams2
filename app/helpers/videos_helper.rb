module VideosHelper
    
    def flag_for(type)
      case type 
          when 1
            render  :partial => "videos/newvideo"
          when 2 
             render :partial => "videos/certified" 
          when 3
             render :partial => "videos/hot"
          when 4
             render :partial => "videos/premiere"
      end
        
    end
         
end
