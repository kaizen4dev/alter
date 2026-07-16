class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :access_tokens, class_name: "Api::AccessToken"

  has_many :links
  has_many :tags

  has_many :books

  has_many :finance_accounts, class_name: "Finance::Account"
  has_many :finance_transfers, class_name: "Finance::Transfer"
end
