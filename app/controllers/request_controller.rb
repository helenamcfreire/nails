require 'will_paginate/array'

class RequestController < ApplicationController

  before_filter :authenticate_user!

  def list

    if current_user.is_beauty?
      @requests = Request.all(:order => 'created_at DESC')
                         .paginate(:page => params[:page], :per_page => 6)
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
    @request.price = params[:request][:price]
    @request.payment = params[:request][:payment]
    @request.status = Request::APROVADO

    if @request.save
      redirect_to '/request/list'
    else
      @requests = Request.all(:order => 'created_at DESC')
                         .paginate(:page => params[:page], :per_page => 6)
      render 'list'
    end

  end

  def reject
    @request = Request.find(params[:id])
    @request.status = Request::RECUSADO

    if @request.save
      redirect_to '/request/list'
    else
      @requests = Request.all(:order => 'created_at DESC')
                         .paginate(:page => params[:page], :per_page => 6)
      render 'list'
    end

  end

end