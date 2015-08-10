class User < ActiveRecord::Base
    
  include Gravtastic
  gravtastic
    
  has_many :playlists
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
    
  if Rails.env.development?
    has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#", :avatar =>"18x18#", }, :default_url => "default_:style.png"
  else
    has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#", :avatar =>"18x18#", }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/  

  #->Prelang (user_login/devise)
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    # The User was found in our database
    return user if user

    # Check if the User is already registered without Facebook
    user = User.where(email: auth.info.email).first

    return user if user

    # The User was not found and we need to create them
    User.create(name:     auth.extra.raw_info.name,
                provider: auth.provider,
                uid:      auth.uid,
                email:    auth.info.email,
                #avatar:   auth.info.image,
                password: Devise.friendly_token[0,20])
  end


  attr_accessor :login
  
  #->Prelang (user_login:devise/username_login_support)
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end


  devise authentication_keys: [:login]
end
