class RequestsController < ApplicationController
  before_action :require_student, only: [:create_request]
  before_action :require_tutor, only: [:accept_request, :my_requests]
  
  def create_request
    if params[:tutor_id]
      Request.create({ tutor_id: params[:tutor_id], student_id: current_student.id })
    end
    
    redirect_to tutor_path(params[:tutor_id])
  end
  
  def accept_request
    @accepted = Accepted.create({tutor_id: current_tutor.id, student_id: params[:student_id]})
    @request = Request.where("tutor_id = ? AND student_id = ?", current_tutor.id, params[:student_id])

    @request.destroy_all
    flash[:success] = "Request Accepted"
    redirect_to request_path
  end
  
  def my_requests
    # @tutor = Tutor.find(current_tutor)
    if tutor_signed_in?
      @pending = current_tutor.student_requests
      @accepted = current_tutor.accepted_students
    elsif student_signed_in?
      @pending = current_student.pending_requests
      @accepted = current_student.accepted_tutors
    end
  end
  
  def destroy
    if params[:student_id]
      @request = Request.where("tutor_id = ? AND student_id = ?", current_tutor.id, params[:student_id])
    elsif params[:tutor_id]
      @request = Request.where("tutor_id = ? AND student_id = ?", params[:tutor_id], current_student.id)
    end
    
    @request.destroy_all
    redirect_to request_path
  end

end
