# -*- encoding: UTF-8 -*-
#class RequestsController < ApplicationController
#  # GET /requests
#  # GET /requests.json
#
#  def index
#  	redirect_to root_path
#  end
#
#  # GET /requests/1
#  # GET /requests/1.json
#  def show
#  	redirect_to root_path
#  end
#
#  # GET /requests/new
#  # GET /requests/new.json
#  def new
#    @request = Request.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @request }
#    end
#  end
#
#  # GET /requests/1/edit
#  def edit
#  	redirect_to root_path
#  end
#
#  # POST /requests
#  # POST /requests.json
#  def create
#    @request = Request.new(params[:request])
#
#	if @request.valid?
#		user = @request.name
#		from = @request.email
#		title = @request.title
#		contents = @request.contents
#		@mail = NoticeMailer.sendmail_confirm(user, from, title, contents).deliver
#		@mail_sent = true
#		render 'finish'
#	else
#		render 'new'
#	end
#  end
#
#  # PUT /requests/1
#  # PUT /requests/1.json
#  def update
#  	redirect_to root_path
#  end
#
#  def destroy
#  	redirect_to root_path
#  end
#
#  def finish
#  end
#end
