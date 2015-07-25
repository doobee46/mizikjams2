class AddBandToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :band, :string
  end
end
