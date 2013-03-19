class RequestController < ApplicationController

  def list

    if current_user.is_beauty?
      @requests = Request.all(:order => 'created_at DESC')
    else
      @requests = Request.find_all_by_user_id(current_user.id, :order => 'created_at DESC')
    end

  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    @request.user_id = current_user.id
    @request.status = Request::EM_PROCESSAMENTO

    if @request.save
      redirect_to '/request/list', :notice => t(:pedido_criado_sucesso)
    else
      render('new')
    end

  end

  def approve
    @request = Request.find(params[:id])
    @request.price = params[:request][:price]
    @request.status = Request::APROVADO

    if @request.save
      redirect_to '/request/list', :notice => t(:pedido_aprovado_sucesso)
    else
      @requests = Request.all(:order => 'created_at DESC')
      render 'list'
    end

  end

  def reject
    @request = Request.find(params[:id])
    @request.status = Request::RECUSADO

    if @request.save
      redirect_to '/request/list', :notice => t(:pedido_recusado_sucesso)
    else
      @requests = Request.all(:order => 'created_at DESC')
      render 'list'
    end

  end

end