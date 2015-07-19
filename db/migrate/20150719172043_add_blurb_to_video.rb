class AddBlurbToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :blurb, :string
  end
end
