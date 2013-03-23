class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index

    if !user_signed_in?
      redirect_to '/users/sign_in'
    else
      redirect_to '/request/list'
    end

  end

end