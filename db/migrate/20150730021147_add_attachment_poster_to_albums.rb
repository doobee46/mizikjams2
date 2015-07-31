class AddAttachmentPosterToAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.attachment :poster
    end
  end

  def self.down
    remove_attachment :albums, :poster
  end
end
