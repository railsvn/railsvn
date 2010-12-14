class AddSlugToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :cached_slug, :string

    add_index :articles, :cached_slug, :unique => true
  end

  def self.down
    remove_column :articles, :cached_slug, :string
  end
end
