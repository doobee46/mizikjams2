class Playlist < ActiveRecord::Base
    has_many :videos , through: :users
end
