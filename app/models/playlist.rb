class Playlist < ActiveRecord::Base
    has_many :videos , through: :users
    
    validate :playlist_limit, :on => :create

    def playlist_limit
        if self.user.things(:reload).count >= 5
            errors.add(:base, "You have reached playlists limit creation.")
        end
     end

end
