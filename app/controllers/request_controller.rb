class RequestController < ApplicationController

  def create
    @request = Request.new(params[:request])
    @request.user_id = current_user.id
    @request.status = Request::EM_PROCESSAMENTO
    @request.save
    redirect_to '/home/index', :notice => 'Congratulations!'
  end

end