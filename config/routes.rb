Rails.application.routes.draw do
 
  resources :playlists

  get 'hearts/create'
    
  namespace :api do  
      resources :videos, :hearts
  end 
 

  #mount BatchVideosUploader::Engine => "/batch_videos_uploader"
  mount Monologue::Engine, at: '/news'
    
    
  get "sitemap.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap 
  get 'admin'          => "pages#admin"
  get 'about'          => "pages#about"
  get 'contact'        => "pages#contact"
  get 'browse'         => "pages#browse"
  get 'streaming'      => "pages#streaming"
  get 'intro'          => "pages#intro"
  get 'news'           => "pages#news"
  get 'manage'         => "pages#manage_videos"
  
    
  resources :category, only: :show
  resources :videos
  resources :hearts, only: :create  

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", omniauth_callbacks: "users/omniauth_callbacks"}, skip: [:sessions, :registrations]
  
  root 'videos#index'
  
  #->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

end
