class CreateThreds < ActiveRecord::Migration
  def self.up
    create_table :threds do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.integer :topic_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :threds
  end
end
