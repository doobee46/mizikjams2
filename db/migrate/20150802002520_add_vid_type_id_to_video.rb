class AddVidTypeIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :vid_type_id, :integer
  end
end
