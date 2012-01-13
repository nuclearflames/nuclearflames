class AddSurnameAliasAboutmeBirthdayToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :surname, :string, :null => false
    add_column :users, :alias, :string
    add_column :users, :aboutme, :string
    add_column :users, :birthday, :time
  end

  def self.down
    remove_column :users, :birthday
    remove_column :users, :aboutme
    remove_column :users, :alias
    remove_column :users, :surname
  end
end
