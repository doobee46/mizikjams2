  class Video < ActiveRecord::Base
    include AlgoliaSearch

    algoliasearch auto_index: true, auto_remove: true do
        attribute :title, :band, :views, :image
        attributesToIndex ['title', 'bands']
        customRanking ['views']
    end
      
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    belongs_to :category
    belongs_to :album
    belongs_to :playlists 
    has_many   :hearts
    has_one    :type
    
    scope :featured, ->{where("views >= 2").order("views DESC").limit(5)}
    
    is_impressionable :column_name => :views, :unique => :session_hash, :counter_cache => true
    
    if Rails.env.production?
    has_attached_file :image, :styles => { :large=> "1214x450#",:medium => "288x150#", :thumb => "100x100>", :avatar =>"64x64>",:featured =>"260x113#", :square =>"578x315#", :share => "600x315>" }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => {app_key: "0hwis6qhiwfulw4", app_secret: "ucwft0zabupis2t", access_token: "dl7rrf28j53wdu81" ,access_token_secret: "y0zp3nluekj54oh",user_id: "367202652", 
                          access_type: "app_folder"},#Rails.root.join("config/dropbox.yml")
                      :dropbox_visibility => 'public'
    else
    has_attached_file :image, :styles => { :large=> "1214x450#",:medium => "288x150#", :thumb => "100x100>",:featured =>"264x150#", :avatar =>"64x64#", :square =>"578x315#",:share => "600x315>" }, :default_url => "default_:style.png"    
    end
    validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    
    def related(category_id)
        #return all videos related based on their category
        videos  = Video.all
        related = []
        videos.each do |video|
            if video.category_id == category_id
                related.push(video)
            end
        end
        related
    end
    
    def self.weekly
        current_week  = (DateTime.now).strftime("%W") 
        grouped = []
        videos  = Video.all
        videos.map do |video|
            impressions = video.impressions
            impressions.map do |impression|
               weeks = impression.created_at.strftime("%W")
                if weeks == (current_week)
                grouped.push(video)
                end
            end
        end
        grouped.uniq
    end
    
    def self.publish_week
        current  = Date.today.beginning_of_week
        end_date = current + 6.days
        "#{current.strftime("%m.%d.%Y")} - #{end_date.strftime("%m.%d.%Y")}"
    end
    
  
    
end
