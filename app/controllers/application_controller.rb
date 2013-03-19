class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale, :set_current_user


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_current_user
    User.current_user = current_user
  end

end