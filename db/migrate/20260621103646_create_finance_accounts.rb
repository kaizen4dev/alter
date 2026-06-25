class CreateFinanceAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :finance_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.integer :group, default: 0
      t.string :name
      t.float :sum
      t.string :currency

      t.timestamps
    end
  end
end
