class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :digest, :null => false
      t.string :salt, :null => false
      t.integer :rank, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
