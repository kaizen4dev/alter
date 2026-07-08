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

  def create
    @account = current_user.finance_accounts.new account_params

    if @account.save
      redirect_to finance_path
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def account_params
    params.expect finance_account: [:name, :sum, :currency]
  end
end
