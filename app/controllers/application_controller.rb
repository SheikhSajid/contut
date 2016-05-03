class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :edit_profile, :go_to_profile, :require_tutor, :require_student
  
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
  
  # def logged_in_as_tutor
  #   if session[:tutor_id]
  #     return true
  #   else
  #     flash[:danger] = "You must be logged as a student perform that action"
  #     return false
  #   end
  # end
  
  def require_tutor
    if session[:tutor_id].nil?
      flash[:danger] = "You must be logged as a tutor perform that action"
      redirect_to root_path
    end
  end
  
  def require_student
    if session[:student_id].nil?
      flash[:danger] = "You must be logged as a student perform that action"
      redirect_to root_path
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
