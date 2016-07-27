class RequestsController < ApplicationController
  before_action :student_signed_in?, only: [:create_request]
  before_action :tutor_signed_in?, only: [:accept_request, :my_requests]
  
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
  
  def my_students
    @tutor = Tutor.find(current_tutor)
    @pending_students = @tutor.student_requests
    @accepted_students = @tutor.accepted_students
  end
  
  def destroy
    @request = Request.where("tutor_id = ? AND student_id = ?", current_tutor.id, params[:student_id])
    @request.destroy_all
    redirect_to request_path
  end

end
