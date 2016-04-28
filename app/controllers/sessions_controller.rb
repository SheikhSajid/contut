class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:success] = "You are already logged in"
      redirect_to root_path
    end
  end
  
  def create
    tutor = Tutor.find_by(email: params[:session][:email].downcase)
    student = Student.find_by(email: params[:session][:email].downcase)
      
    if tutor and tutor.authenticate(params[:session][:password])
      session[:tutor_id] = tutor.id
      flash[:success] = "You are now logged in as a tutor"
      redirect_to root_path
    elsif student and student.authenticate(params[:session][:password])
      session[:student_id] = student.id
      flash[:success] = "You are now logged in as a student"
      redirect_to root_path
    else
      flash.now[:danger] = "Incorrect email/password combination"
      render :new
    end
  end

  def destroy
    session[:tutor_id] = nil;
    session[:student_id] = nil;
    redirect_to root_path
  end
end