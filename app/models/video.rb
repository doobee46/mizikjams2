class Video < ActiveRecord::Base
    
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
    has_attached_file :image, :styles => { :large=> "1214x450#",:medium => "288x150#", :thumb => "100x100>", :avatar =>"64x64>",:featured =>"264x150#", :square =>"578x315#", :share => "600x315>" }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => {app_key: "q5tdxqhs3jgxg11", app_secret: "brrmzb5u64f78fg", access_token: "9qtad7oua57pqg45" ,access_token_secret: "9nsq9yulhvfzljv",user_id: "448830849", 
                      access_type: "app_folder"}#Rails.root.join("config/dropbox.yml")
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
    
    def self.week
        current  = Date.today.beginning_of_week
        end_date = current + 6.days
        "#{current.strftime("%m.%d.%Y")} - #{end_date.strftime("%m.%d.%Y")}"
    end
    
  
    
end
