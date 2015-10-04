module Api  
    class HeartsController < Api::BaseController

    private

      def heart_params
         params.require(:heart).permit(:video_id)
      end

      def query_params
        params.permit(:name)
      end

  end
end  