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
    sub_contents = photo_images.sub
    SUB_CONTENT_MAX.times { |i| sub_contents[i] ||= photo_images.build(role: "sub") }
    sub_contents
  end

  def like_user(user)
   likes.find_by(user_id: user)
  end

end
