class Film < ApplicationRecord
  has_one_attached :picture

  belongs_to :user

  enum :category, [ :movies, :series, :teleshows, :cartoons, :anime ]
  enum :status, [ :watching, :finished, :dropped, :planning, :hiatus ]
end
