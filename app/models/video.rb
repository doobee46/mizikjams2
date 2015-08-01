class Video < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    belongs_to :category
    belongs_to :album
    has_many   :hearts
    
    is_impressionable :column_name => :views, :unique => :session_hash, :counter_cache => true
    
    if Rails.env.production?
    has_attached_file :image, :styles => { :large=> "1214x450#",:medium => "288x150#", :thumb => "100x100>", :avatar =>"64x64>", :square =>"578x315#" }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => {app_key: "0hwis6qhiwfulw4", app_secret: "ucwft0zabupis2t", access_token: "3jbzum7yqwebiim2" ,access_token_secret: "mvfig3fbyls11sj",user_id: "367202652", 
                       access_type: "app_folder"}
        #Rails.root.join("config/dropbox.yml")
    else
    has_attached_file :image, :styles => { :large=> "1214x450#",:medium => "288x150#", :thumb => "100x100>", :avatar =>"64x64#", :square =>"578x315#" }, :default_url => "default_:style.png"    
    
    
    end
    validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
