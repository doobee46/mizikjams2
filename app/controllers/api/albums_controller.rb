module Api  
    class AlbumsController < Api::BaseController

    private

      def albums_params
          params.require(:album).permit(:title, :info, :poster)
      end

      def query_params
          params.permit(:title, :info, :poster)
      end

  end
end  