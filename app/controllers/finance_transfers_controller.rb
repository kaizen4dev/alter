class FinanceTransfersController < ApplicationController
  def new
    if params[:source].blank? && params[:destination].blank?
      redirect_back fallback_location: finance_path,
        notice: "Select accounts with left and right mouse buttons on pc, or short and long tap on mobile."
    end

    @transfer = current_user.finance_transfers.new(source_id: params[:source], destination_id: params[:destination])
  end

  def create
    @transfer = current_user.finance_transfers.new transfer_params
    amount = @transfer.slice :sent, :received

    if @transfer.save
      @transfer.source.update sum: @transfer.source.sum - amount[:sent] unless @transfer.sent.blank?
      @transfer.destination.update sum: @transfer.destination.sum + amount[:received] unless @transfer.received.blank?
      redirect_to finance_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @transfer = current_user.finance_transfers.find params[:id]
  end

  def update
    @transfer = current_user.finance_transfers.find params[:id]
    old = @transfer.slice :sent, :received

    if @transfer.update transfer_params
      new = @transfer.slice :sent, :received
      @transfer.source.update sum: @transfer.source.sum + old[:sent] - new[:sent] unless @transfer.source.blank?
      @transfer.destination.update sum: @transfer.destination.sum - old[:received] + new[:received] unless @transfer.destination.blank?
      redirect_to finance_path
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    current_user.finance_transfers.find(params[:id]).destroy
    redirect_to finance_path
  end

  private

  def transfer_params
    params.expect finance_transfer: [ :note, :source_id, :destination_id, :sent, :received ]
  end
end
