class Api::AccessToken < ApplicationRecord
  belongs_to :user, class_name: "User"
  validates :name, :digest, presence: true
  validates :digest, uniqueness: true

  default_scope { where revoked: false }

  def revoke
    self.update revoked: true
  end
end
