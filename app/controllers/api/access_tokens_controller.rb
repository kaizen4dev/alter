class Api::AccessTokensController < ApplicationController
  def index
    @tokens = current_user.access_tokens
  end

  def show
    @token = current_user.access_tokens.find params[:id]
  end

  def new
    @token = current_user.access_tokens.new
  end

  def create
    @token_value = SecureRandom.hex(32)
    @token = current_user.access_tokens.new name: params[:api_access_token][:name]
    @token.digest = Digest::SHA256.hexdigest(@token_value)

    if @token.save
      render :show
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @token = current_user.access_tokens.find params[:id]
  end

  def update
    @token = current_user.access_tokens.find params[:id]

    if @token.update name: params[:api_access_token][:name]
      render :show
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    current_user.access_tokens.find(params[:id]).revoke
    redirect_to api_access_tokens_path
  end
end
