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
                      :dropbox_credentials => {app_key: "0hwis6qhiwfulw4", app_secret: "ucwft0zabupis2t", access_token: "3jbzum7yqwebiim2" ,access_token_secret: "mvfig3fbyls11sj",user_id: "367202652", 
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
    
    def self.group_by_impressions 
        #return an hash with videos and an array for their impressions
        @grouped={}
        videos = Video.all
        videos.each do |video|
            video.impressions.map do |impression|
                @grouped[video.title] ||= []
                @grouped[video.title].push((impression.created_at).to_s)
            end
        end
        @grouped
    end
    
    def self.current_week_plays
        week = (DateTime.now-6.days..DateTime.now).map {|date| date.strftime("%F %X"+"UTC")}
        @grouped = self.group_by_impressions 
        @grouped.map do |k,v|
        @video_list = []
         v.each do |value|
            week.each do |day|
            if value == day
            @video_list.push(k)
            end
          end
        end
         video = @video_list.uniq
         video.flatten
      end 
    end
    
end
