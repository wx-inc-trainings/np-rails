class ApplicationController < ActionController::Base
  before_action :switch_locale
  def switch_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  include Wor::Paginate
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized
    render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
  end
end
