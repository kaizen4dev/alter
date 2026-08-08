class SplitAmountInFinanceTransfers < ActiveRecord::Migration[8.1]
  def up
    add_column :finance_transfers, :sent, :float
    add_column :finance_transfers, :received, :float

    Finance::Transfer.reset_column_information

    Finance::Transfer.find_each do |transfer|
      if transfer.category == :expenses
        transfer.update_column :sent, transfer.amount
      else
        transfer.update_column :received, transfer.amount
      end
    end

    remove_columns :finance_transfers, :amount, :currency
  end

  def down
    add_column :finance_transfers, :amount, :float
    add_column :finance_transfers, :currency, :string

    Finance::Transfer.reset_column_information

    Finance::Transfer.find_each do |transfer|
      transfer.update_column :amount, (transfer.sent || transfer.received)
      transfer.update_column :currency, (transfer.sent.nil? ? transfer.destination.currency : transfer.source.currency)
    end

    remove_columns :finance_transfers, :sent, :received
  end
end
