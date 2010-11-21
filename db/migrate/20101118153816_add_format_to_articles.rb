class AddFormatToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :source_format, :string, :default => 'plain', :null => false
  end

  def self.down
    remove_column :articles, :source_format
  end
end
