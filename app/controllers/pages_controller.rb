class PagesController < ApplicationController
    
    before_filter :authenticate_user!, except: [:about, :contact, :browse]
    
  def admin
    @video = Video.new
  end

  def about
  end

  def contact
  end

  def browse
      if params[:query].present?
          @videos = Video.search(params[:query], page: params[:page],:per_page => 20)
      else
          @videos = Video.paginate(:page => params[:page], :per_page => 20)
      end
      @category = Category.all
  end
    
    
     
end
