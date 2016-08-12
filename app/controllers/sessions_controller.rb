class SessionsController < ApplicationController
  def new
    if logged_in? or tutor_signed_in?
      flash[:success] = "You are already logged in"
      redirect_to root_path
    end
  end
  
  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
   
    if admin and admin.authenticate(params[:session][:password])
      session[:admin_id] = admin.id
      flash[:success] = "You are now logged in as an admin"
      redirect_to root_path
    else
      flash.now[:danger] = "Incorrect email/password combination"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil;
    redirect_to root_path
  end
end