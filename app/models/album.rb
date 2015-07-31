class Album < ActiveRecord::Base
    has_many :videos
    
    if Rails.env.development?
        has_attached_file :poster, :styles => { :thumb => "100x100>", :avatar =>"64x64#" }, :default_url => "default_:style.png"
    else
        has_attached_file :poster, :styles => { :thumb => "100x100>", :avatar =>"64x64>" }, :default_url => "default_:style.png",
                          :storage => :dropbox,
                          :dropbox_credentials => Rails.root.join("config/dropbox.yml")
    end
    validates_attachment :poster, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
    validates_attachment_content_type :poster, :content_type => /\Aimage\/.*\Z/
end
