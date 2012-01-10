class AddTitleDescriptionToStorage < ActiveRecord::Migration
  def self.up
    add_column :storages, :title, :string
    add_column :storages, :description, :string
  end

  def self.down
    remove_column :storages, :description
    remove_column :storages, :title
  end
end
