class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :vid_type

      t.timestamps
    end
  end
end
