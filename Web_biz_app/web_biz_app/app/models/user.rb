# coding: utf-8
class User < ApplicationRecord
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise    :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
  has_many  :likes
  has_many  :comments
  has_many  :photos
  validates :username,      presence: true
 # validates :password,   length: { minimum: 8 }
  validates :email,      presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  mount_uploader :avatar, AvatarUploader

  def self.search(keyword, maxfare)
    user_ids = [] # 検索でヒットしたユーザーのidを格納する配列
    
    #入力がある場合とない場合で分ける
    if keyword.presence
    #入力文字列を空白で区切ってリストに格納
      patterns = keyword.split(/[ , ]/)
      sql_body = ''
      tagged_users = []

      #SQL文を作成する
      patterns.each do |pattern|
        sql_body += ' and ' unless sql_body.blank?
        sql_body += " concat(username, works, profile) like '%#{pattern}%' "
      end
      sql = "select * from users where #{sql_body} order by id desc"
    
    #find_by_sqlで条件を満たすユーザーを取得し、それらのidを取得する
      user_ids << User.find_by_sql(sql).map(&:id)

      # リストをidに変換
      tagged_users.each do |photo|
        user_ids << user.ids
      end

      user_ids.flatten!
      where(:id => user_ids)
    else
      User.all
    end
  end
end
