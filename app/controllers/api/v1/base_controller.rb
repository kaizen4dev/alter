class Api::V1::BaseController < ActionController::API
  before_action :authenticate_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_user
    @token.user
  end

  private

  def authenticate_token
    @token = Api::AccessToken.find_by digest: Digest::SHA256.hexdigest(request.headers[:AccessToken]) if request.headers[:AccessToken]
    render json: { errors: [ "Invalid AccessToken." ] } if @token.nil?
  end

  def record_not_found
    head :not_found
  end
end
