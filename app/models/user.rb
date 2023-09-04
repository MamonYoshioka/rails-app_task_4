class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

   #フォロー機能のアソシエーション
  #follower_id=自分
  #followed_id=相手

  #自分がフォローしたり、アンフォローしたりするための記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォロー一覧を表示するための記述①
  has_many :followings, through: :relationships, source: :followed


  has_many :reverse_relationshiops, class_name: "Relationship", foreign_key: "follwed_id", dependent: :destroy
  #フォロワー一覧を表示するための記述②
  has_many :followers, through: :reverse_relationships, source: :follower


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 30 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
