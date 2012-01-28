class CreateTimelines < ActiveRecord::Migration
  def self.up
    create_table :timelines do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.date :date, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :timelines
  end
end
