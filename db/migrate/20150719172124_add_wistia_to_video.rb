class AddWistiaToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :Wistia, :string
  end
end
