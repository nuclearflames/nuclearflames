class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.integer :owner_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
