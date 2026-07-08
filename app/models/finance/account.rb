class Finance::Account < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :transfers_in, foreign_key: :destination_id, class_name: "Finance::Transfer"
  has_many :transfers_out, foreign_key: :source_id, class_name: "Finance::Transfer"
  enum :group, [ :expense, :lent, :saving, :deleted ]

  validates :sum, :name, :currency, presence: true

  def transfers
    transfers_in.or(transfers_out).to_a
  end

  def relocations
    transfers_in.relocations.or(transfers_out.relocations).to_a
  end
end
