class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :current_user, :logged_in?, :edit_profile, :go_to_profile, 
                :require_tutor, :require_student, :logout, :admin_signed_in?
    
  # To keep some of the legacy code working, the following two methods are needed
  def current_user
    current_student
  end

  def logged_in?
    student_signed_in?
  end
  
  # def logged_in_as_tutor
  #   if session[:tutor_id]
  #     return true
  #   else
  #     flash[:danger] = "You must be logged as a student perform that action"
  #     return false
  #   end
  # end
  
  def signed_in?
    tutor_signed_in? || student_signed_in? || admin_signed_in?
  end
  
  def require_tutor
    if !tutor_signed_in?
      flash[:danger] = "You must be logged as a tutor perform that action"
      redirect_to root_path
    end
  end
  
  def require_student
    if !student_signed_in?
      flash[:danger] = "You must be logged as a student perform that action"
      redirect_to root_path
    end
  end
  
  def edit_profile
    if tutor_signed_in?
      return edit_tutor_registration_path(current_tutor.id)
    elsif student_signed_in?
      return edit_student_registration_path(current_student.id)
    end
  end
  
  def go_to_profile
    if tutor_signed_in?
      return tutor_path(current_tutor.id)
    elsif student_signed_in?
      return student_path(current_student.id)
    end
  end
  
  def admin_signed_in?
    session[:admin_id]
  end
  
  def logout
    if tutor_signed_in?
      return destroy_tutor_session_path
    elsif student_signed_in?
      return destroy_student_session_path
    elsif admin_signed_in?
      return admin_logout_path
    end
  end
  
  
  
  # def opportunity(lambda1, lambda2)
  #   if lambda1.()
  #     @opportunities += 1
  #   elsif lambda2.()
  #     @performances += 1
  #   end
  # end
  
  # protected
  
  #   def configure_permitted_parameters
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :gender, :rate, :description, :city, :area, :zip, :full_address, :phone, :profile_picture_file_name, :profile_picture_content_type, :profile_picture_file_size, :profile_picture_updated_at, :degree, :institution, :year])
  #     devise_parameter_sanitizer.permit(:account_update, keys: [:fname, :lname, :gender, :rate, :description, :city, :area, :zip, :full_address, :phone, :degree, :institution, :year])
  #   end
end
  

