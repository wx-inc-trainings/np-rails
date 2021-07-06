class ApiController < ApplicationController
  before_action :authenticate_user!
  before_action :switch_locale
  def switch_locale
    I18n.locale = current_user.locale || I18n.default_locale
  end
end
