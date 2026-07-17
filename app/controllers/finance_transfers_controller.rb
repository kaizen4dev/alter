class FinanceTransfersController < ApplicationController
  def new
    if params[:source].blank? && params[:destination].blank?
      redirect_back fallback_location: finance_path,
        notice: "Please select accounts with left and right mouse buttons."
    end

    @transfer = current_user.finance_transfers.new(source_id: params[:source], destination_id: params[:destination])
  end

  def create
    @transfer = current_user.finance_transfers.new transfer_params
    @transfer.amount = amount[:sent] || amount[:received]
    @transfer.fee = amount[:sent] - amount[:received] unless @transfer.source.blank? || @transfer.destination.blank? or @transfer.source.currency != @transfer.destination.currency
    @transfer.currency = if @transfer.source then @transfer.source.currency else @transfer.destination.currency end

    if @transfer.save
      @transfer.source.update sum: @transfer.source.sum - amount[:sent] unless @transfer.source.blank?
      @transfer.destination.update sum: @transfer.destination.sum + amount[:received] unless @transfer.destination.blank?
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
    @transfer.amount = amount[:sent] || amount[:received]
    @transfer.fee = amount[:sent] - amount[:received] unless @transfer.source.blank? || @transfer.destination.blank? or @transfer.source.currency != @transfer.destination.currency

    if @transfer.update transfer_params
      # @transfer.source.update sum: @transfer.source.sum - amount[:sent] unless @transfer.source.blank?
      # @transfer.destination.update sum: @transfer.destination.sum + amount[:received] unless @transfer.destination.blank?
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
    params.expect finance_transfer: [ :note, :source_id, :destination_id ]
  end

  def amount
    p = params.expect finance_transfer: [ :sent, :received ]
    p.transform_values { |v| if v.blank? then 0 else v.to_i end }
  end
end
