class User < ActiveRecord::Base
  ROLES = %w(member moderator)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, allow_blank: false
  validates :role, inclusion: { in: ROLES }

  # I have to specify the foreign key because I wanted my posts
  # to refer to their user as 'creator'
  # dependent: :destory means that if a user is deleted, so are their posts
  has_many :posts, foreign_key: 'creator_id', class_name: 'Post', dependent: :destroy


  # instance methods
  def is_role?(given_role)
    role == given_role.to_s
  end
end
