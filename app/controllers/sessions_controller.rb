class SessionsController < ApplicationController
  def new
    if logged_in? or tutor_signed_in?
      flash[:success] = "You are already logged in"
      redirect_to root_path
    end
  end
  
  def create
    student = Student.find_by(email: params[:session][:email].downcase)
   
    if student and student.authenticate(params[:session][:password])
      session[:student_id] = student.id
      flash[:success] = "You are now logged in as a student"
      redirect_to root_path
    else
      flash.now[:danger] = "Incorrect email/password combination"
      render :new
    end
  end

  def destroy
    session[:student_id] = nil;
    redirect_to root_path
  end
end