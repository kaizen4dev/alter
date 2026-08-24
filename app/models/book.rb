class Book < ApplicationRecord
  has_one_attached :picture

  belongs_to :user

  enum :status, [ :reading, :finished, :dropped, :planning, :hiatus ]
  enum :category, [ "fiction", "non-fiction", "manga", "novels" ]
end
