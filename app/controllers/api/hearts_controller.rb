module Api  
    class heartsController < Api::BaseController

    private

      def heart_params
         params.require(:heart).permit(:video_id)
      end

      def query_params
        params.permit(:name)
      end

  end
end  