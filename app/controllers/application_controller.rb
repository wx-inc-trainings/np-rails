class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  include Wor::Paginate
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  
  def not_authorized
    render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
  end
end
