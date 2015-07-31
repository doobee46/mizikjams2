class HeartsController < ApplicationController
    
  def create
      @heart = Heart.new(heart_params) 
      respond_to do |format|
      format.js
  	 end
  end

  private

  def heart_params
      params.require(:heart).permit(:video_id)
  end
    
end
