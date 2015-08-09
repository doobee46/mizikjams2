class Category < ActiveRecord::Base
    searchkick
    has_many :videos
end
