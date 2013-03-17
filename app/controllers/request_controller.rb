class RequestController < ApplicationController

  def list

    if current_user.is_beauty?
      @requests = Request.all
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

    if has_requests_being_processed?
      redirect_to '/request/new', :notice => t(:ja_tem_pedido_sendo_processado)
    elsif @request.save
      redirect_to '/request/list', :notice => t(:pedido_criado_sucesso)
    else
      render('new')
    end

  end

  def approve
    puts(params[:request][:price])
    @request = Request.find(params[:id])
    @request.price = params[:request][:price]
    @request.status = Request::APROVADO

    if is_price_blank?
      redirect_to '/request/list', :notice => t(:faltou_informar_valor)
    elsif @request.save
      redirect_to '/request/list', :notice => t(:pedido_aprovado_sucesso)
    else
      @requests = Request.all
      render 'list'
    end

  end

  def reject
    @request = Request.find(params[:id])
    @request.status = Request::RECUSADO

    @request.save
    redirect_to '/request/list', :notice => t(:pedido_recusado_sucesso)

  end

  def has_requests_being_processed?
    @requests_being_processed = Request.all :include => [:user], :conditions => ['users.is_beauty = ? AND users.id = ? AND status = ?', false, current_user.id, 'P']
    @requests_being_processed.any?
  end

  def is_price_blank?
    @request.status == 'A' && @request.price.blank?
  end

end