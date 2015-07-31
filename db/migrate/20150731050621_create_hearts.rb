class CreateHearts < ActiveRecord::Migration
  def change
    create_table :hearts do |t|
      t.references :video, index: true
        
      t.timestamps
    end
  end
end
