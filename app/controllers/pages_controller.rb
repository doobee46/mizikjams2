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
      @videos   = Video.all
      @category = Category.all
     
  end
    
    
     
end
