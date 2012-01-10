class AddEmailStatusToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :status, :string
  end

  def self.down
    remove_column :users, :status
    remove_column :users, :email
  end
end
