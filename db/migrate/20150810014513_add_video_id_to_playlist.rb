class AddVideoIdToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :video_id, :integer
  end
end
