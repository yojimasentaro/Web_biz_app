class PhotoImage < ApplicationRecord
  belongs_to     :photo
  enum role: %i(main sub)
  mount_uploader :content, PhotoImageUploader
end
