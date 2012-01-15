class AddEmailStatusToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string, :null => false
    add_column :users, :status, :string, :default => "Inactive"
  end

  def self.down
    remove_column :users, :status
    remove_column :users, :email
  end
end
