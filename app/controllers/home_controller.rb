class HomeController < ApplicationController

  def index

    @request = Request.new

    if !user_signed_in?
      redirect_to '/users/sign_in'
    else
      @requests = Request.find_all_by_user_id(current_user.id, :order => 'created_at DESC')
    end

  end

end