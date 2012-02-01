class AddFontSizeColorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :font, :string, :default => "Times New Roman"
    add_column :users, :color, :string, :default => "White"
    add_column :users, :size, :integer, :default => 16
  end

  def self.down
    remove_column :users, :size
    remove_column :users, :color
    remove_column :users, :font
  end
end
