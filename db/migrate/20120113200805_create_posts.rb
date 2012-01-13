class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.integer :thred_id, :null => false
      t.integer :owner_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
