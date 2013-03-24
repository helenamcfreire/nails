require 'will_paginate/array'

class RequestController < ApplicationController

  before_filter :authenticate_user!

  def list

    if current_user.is_beauty?
      @requests = Request.all(:order => 'created_at DESC')
                         .paginate(:page => params[:page], :per_page => 4)
    else
      @requests = Request.find_all_by_user_id(current_user.id, :order => 'created_at DESC')
                         .paginate(:page => params[:page], :per_page => 6)
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
      redirect_to '/request/list'
    else
      render('new')
    end

  end

  def approve
    @request = Request.find(params[:id])
    @request.price = params[:request][:price].gsub(',', '.')
    @request.payment = params[:request][:payment]
    @request.status = Request::APROVADO

    if @request.save
      redirect_to :controller => 'request', :action => 'list', :page => params[:page]
    else
      flash[:error] = @request.errors.full_messages
      @requests = Request.all(:order => 'created_at DESC')
                         .paginate(:page => params[:page], :per_page => 4)
      redirect_to :controller => 'request', :action => 'list', :page => params[:page]
    end

  end

  def reject
    @request = Request.find(params[:id])
    @request.status = Request::RECUSADO

    @request.save
    redirect_to :controller => 'request', :action => 'list', :page => params[:page]

  end

end