class CreateStorages < ActiveRecord::Migration
  def self.up
    create_table :storages do |t|
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :storages
  end
end
