class RemoveFeeFromFinanceTransfers < ActiveRecord::Migration[8.1]
  def change
    remove_column :finance_transfers, :fee, :float
  end
end
