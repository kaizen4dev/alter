class Api::V1::BaseController < ActionController::API
  before_action :authenticate_token

  def current_user
    @token.user
  end

  private

  def authenticate_token
    @token = Api::AccessToken.find_by digest: Digest::SHA256.hexdigest(request.headers[:AccessToken])
    render json: { errors: [ "Invalid AccessToken." ] } if @token.nil?
  end
end
