class FinanceAccountsController < ApplicationController
  def show
    @expense_accounts = current_user.finance_accounts.expense
    @lent_accounts = current_user.finance_accounts.lent
    @saving_accounts = current_user.finance_accounts.saving
    @transfers = current_user.finance_transfers
  end

  def new
    @account = current_user.finance_accounts.new group: params[:group]
  end
end
