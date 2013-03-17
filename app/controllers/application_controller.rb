class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale


  def set_locale
    # se params[:locale] for nulo, então deve-se utilizar I18n.default_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
