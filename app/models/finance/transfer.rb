class Finance::Transfer < ApplicationRecord
  belongs_to :user, class_name: "User"

  belongs_to :source, class_name: "Finance::Account", optional: true
  belongs_to :destination, class_name: "Finance::Account", optional: true

  scope :relocations, -> { where.not(source_id: nil).where.not(destination_id: nil) }
  scope :incomes, -> { where(source_id: nil).where.not(destination_id: nil) }
  scope :expenses, -> { where(destination_id: nil).where.not(source_id: nil) }

  def category
    case [ source_id.blank?, destination_id.blank? ]
    when [ false, false ] then :relocations
    when [ true, false ] then :incomes
    when [ false, true ] then :expenses
    else nil
    end
  end

  def self.categories
    [ :relocations, :incomes, :expenses ]
  end
end
