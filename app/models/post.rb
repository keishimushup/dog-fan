class Post < ApplicationRecord
  #後で動画に変更
  has_one_attached :image
  belongs_to :user
end
