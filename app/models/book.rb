class Book < ApplicationRecord
  belongs_to :user

  enum :status, [ :reading, :finished, :dropped, :planning, :hiatus ]
  enum :category, [ "fiction", "non-fiction", "manga", "novels" ]
end
