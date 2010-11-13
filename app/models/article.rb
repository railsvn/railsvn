class Article < ActiveRecord::Base
  scope :recent, lambda { |num_item = 10| order("created_at DESC").limit(num_item) }

  attr_accessible :title, :body

  belongs_to :author, :class_name => 'User'
  has_many :comments, :dependent => :delete_all

  validates :title, :presence => true
  validates :body, :presence => true
end
