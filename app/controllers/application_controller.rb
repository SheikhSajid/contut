class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :edit_profile, :go_to_profile
  
  def current_user
    if session[:tutor_id]
      @curr_user ||= Tutor.find_by(id: session[:tutor_id])
    elsif session[:student_id]
      @curr_user ||= Student.find_by(id: session[:student_id])
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
  
  def edit_profile
    if session[:tutor_id]
      return edit_tutor_path(current_user)
    elsif session[:student_id]
      return edit_student_path(current_user)
    end
  end
  
  def go_to_profile
    if session[:tutor_id]
      return tutor_path(current_user)
    elsif session[:student_id]
      return student_path(current_user)
    end
  end
end
