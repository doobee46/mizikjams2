class AddAttachmentAlbumToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :album
    end
  end

  def self.down
    remove_attachment :videos, :album
  end
end
