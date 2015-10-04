module Api  
    class VideosController < Api::BaseController

    private

      def video_params
         params.require(:video).permit(:title, :description, :image ,:key ,:blurb, :band, :album,:slug, :category_id, :vid_type_id)
      end

      def query_params
          params.permit(:id, :title , :band)
      end

  end
end  