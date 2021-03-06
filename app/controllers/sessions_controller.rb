class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    user = User.where(email: params[:session][:email]).first
	if user && user.authenticate(params[:session][:password])
	  sign_in user
	  redirect_back_or user
	else
      flash.now[:error] = 'invalid email/password combination' # not quite right
	  render 'new'
	end
  end

  def destroy
    sign_out
	redirect_to root_path
  end
end
