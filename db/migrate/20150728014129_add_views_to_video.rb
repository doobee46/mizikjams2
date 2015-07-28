class AddViewsToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :views, :integer ,:default => 0
  end
end
