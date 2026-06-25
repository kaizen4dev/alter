class CreateFinanceTransfers < ActiveRecord::Migration[8.1]
  def change
    create_table :finance_transfers do |t|
      t.float :amount
      t.float :fee
      t.string :currency
      t.references :source, foreign_key: { to_table: :finance_accounts }
      t.references :destination, foreign_key: { to_table: :finance_accounts }
      t.string :note
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
