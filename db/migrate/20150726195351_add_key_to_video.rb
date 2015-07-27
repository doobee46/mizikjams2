class AddKeyToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :key, :string
  end
end
