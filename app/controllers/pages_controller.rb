class PagesController < ApplicationController
    
      def admin
        
      end

      def about
      end

      def contact
      end
     
      def create
        @video = Video.new(video_params)
        @video.save
        respond_with(@video)
      end
  
end
