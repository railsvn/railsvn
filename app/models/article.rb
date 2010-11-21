class Article < ActiveRecord::Base
  scope :recent, lambda { |num_item = 10| order("created_at DESC").limit(num_item) }
  scope :published, where(:published => true)

  attr_accessible :title, :body, :source_format, :published


  belongs_to :author, :class_name => 'User'
  has_many :comments, :dependent => :delete_all

  validates :title, :presence => true
  validates :body, :presence => true

  def self.source_format_options
    [['Plain text', 'plain'], ['HTML', 'html'], ['Markdown', 'markdown']]
  end
end
