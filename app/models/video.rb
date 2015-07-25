class Video < ActiveRecord::Base
   if Rails.env.development?
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64#", }, :default_url => "default_:style.png"
  else
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end
  validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
