class CategoryController < ApplicationController
    
    respond_to :html ,:js, :json
    
    def show
        @category = Category.find(params[:id])
        @videos = Video.includes(:impressions, :hearts, :category).paginate(page: params[:page], per_page: 20).order('created_at DESC')
        respond_with(@category)
    end 
        
        
end
