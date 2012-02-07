class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
	t.string :title, :null => false
	t.integer :user_id, :null => false
	t.string :description, :null => false
	t.string :status, :null => false
	t.decimal :lat, :precision => 15, :scale => 10, :null => false
	t.decimal :long, :precision => 15, :scale => 10, :null => false
    end
  end

  def self.down
    drop_table :locations
  end
end
