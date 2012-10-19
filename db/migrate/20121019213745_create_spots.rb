class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string  :name,       :limit => 100,     :null => false
      t.string  :addr1,      :limit => 100,     :null => false
      t.string  :addr2,      :limit => 100,     :null => false
      t.boolean :has_food,   :default => false, :null => false
      t.boolean :has_drinks, :default => false, :null => false
      t.boolean :has_music,  :default => false, :null => false
      t.timestamps
    end
  end
end
