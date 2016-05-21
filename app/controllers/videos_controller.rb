class VideosController < ApplicationController
  
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  respond_to :html ,:js, :json

  def index
        
      if params[:q].present?
          @videos = @q.result.paginate(page: params[:page],:per_page => 20).order(created_at: :desc)
          @categories =Category.all
      else
          @videos = Video.all.includes(:impressions, :hearts, :category).paginate(page: params[:page], per_page: 20).order('created_at DESC')
          @main   = @videos.limit(10).order(created_at: :desc)
          @top  = @videos.weekly.shuffle.sample(10)
          @hot_video = @videos.weekly.shuffle.take(10).uniq
          @featured = @videos.featured.limit(10)
          @categories =Category.all
          prepare_meta_tags title: "Video Library", 
                            description: "All the new releases from the best caribbean artist and group ",
                            keywords:  "kompa carimi tvice  haiti zouk t-vice radio show rock jazz mizik kreyol tabou compas rara music festival paris"
          respond_with(@videos)

      end
        
  end

  def show
      @videos = Video.preload(:impressions, :hearts, :category).paginate(page: params[:page], per_page: 20).order('created_at DESC').limit(20)
      @related = @video.related(@video.category_id).sample(12)
      @featured = Video.weekly.take(4)
      impressionist @video 
      prepare_meta_tags(title: @video.title,
                      description: @video.blurb,
                      image: @video.image.url(:share),
                      twitter: {card: "summary_large_image"})
      respond_with(@video)  
  end

  def new
    @video = Video.new
    respond_with(@video)
  end

  def edit
  end

  def create
    @video = Video.new(video_params)
    @video.save
    respond_with(@video)
  end

  def update
    @video.update(video_params)
    respond_with(@video)
  end

  def destroy
    @video.destroy
    respond_with(@video)
  end

  private
    def set_video
      @video = Video.friendly.find(params[:id])
      #@video = Video.find(params[:id])
    end

    def video_params
        params.require(:video).permit(:title, :description, :image ,:key ,:blurb, :band, :album,:slug, :category_id, :vid_type_id)
    end
end
