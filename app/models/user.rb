class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => true }
  validates :password, :presence => { :on => :create },
                       :length => { :within => 6..20, :allow_blank => true },
                       :confirmation => true

  has_many :articles, :foreign_key => :author_id, :dependent => :destroy
  has_many :comments, :foreign_key => :author_id, :dependent => :delete_all

  AVATAR_SIZES = {
      :tiny   => 16,
      :small  => 40,
      :normal => 80,
      :large  => 160,
      :huge   => 320,
  }

  def avatar_url(size = :normal)
    size_in_pixel = AVATAR_SIZES[size] || 80 
    self.gavatar_url(AVATAR_SIZES[size])
  end

  def gavatar_url(size = 80)
    hash = Digest::MD5.hexdigest(self.email)
    "http://www.gravatar.com/avatar/#{hash}.png?d=wavatar&s=#{size}"
  end

  def display_name
    self.email
  end
end
