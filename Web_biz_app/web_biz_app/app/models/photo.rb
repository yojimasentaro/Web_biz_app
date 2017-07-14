# coding: utf-8
class Photo < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_many   :comments,         dependent: :destroy
  has_many   :likes,            dependent: :destroy
  has_many   :photo_images, dependent: :destroy
  has_one    :main, class_name: "PhotoImage"
  accepts_nested_attributes_for :photo_images, allow_destroy: true, reject_if: :all_blank
  validates  :catch_copy, :concept, :title,  presence: true

  paginates_per 8

  SUB_CONTENT_MAX = 2
  def set_sub_contents
    sub_contents = photo.sub
    SUB_CONTENT_MAX.times { |i| sub_contents[i] ||= photo_images.build(role: "sub") }
    sub_contents
  end

  def like_user(user)
   likes.find_by(user_id: user)
  end

  def self.search(keyword)
    photo_ids = [] # 検索でヒットしたユーザーのidを格納する配列
    
    #入力がある場合とない場合で分ける
    if keyword.presence
    #入力文字列を空白で区切ってリストに格納
      patterns = keyword.split(/[ , ]/)
      sql_body = ''
      tagged_photos = []

      #SQL文を作成する
      patterns.each do |pattern|
        sql_body += ' and ' unless sql_body.blank?
        sql_body += " concat(title, concept) like '%#{pattern}%' "
        tagged_photos.push(Photo.tagged_with(pattern)) # "pattern"というタグを持つPhotoのリストがpushされる
      end
      sql = "select * from photos where #{sql_body} order by id desc"
    
    #find_by_sqlで条件を満たすユーザーを取得し、それらのidを取得する
      photo_ids << Photo.find_by_sql(sql).map(&:id)

      # リストをidに変換
      tagged_photos.each do |photo|
        photo_ids << photo.ids
      end

      photo_ids.flatten!
      where(:id => photo_ids)
    else
      Photo.all
    end
  end    
end
