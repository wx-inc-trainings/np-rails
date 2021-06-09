class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  include Wor::Paginate
  Wor::Paginate.configure do |config|
    config.formatter = Wor::Paginate::Formatters::PankoFormatter
  end
end
