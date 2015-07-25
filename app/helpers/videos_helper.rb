module VideosHelper
    
    def video_type(type)
      case type 
      when "success" then "ui green message"
      when "error" then "ui red message"
      when "notice" then "ui blue message"
      end
    end
    
end
