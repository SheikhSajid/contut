class RequestsController < ApplicationController
  before_action :require_student, only: [:create]
  before_action :require_tutor, only: [:accept]
  before_action :require_signed_in_user, only: [:index, :destroy]
  before_action :check_validity, only: [:destroy]
  
  def create
    if params[:tutor_id]
      Request.create({ tutor_id: params[:tutor_id], student_id: current_student.id })
    end
    
    redirect_to tutor_path(params[:tutor_id])
  end
  
  def accept
    req = Request.where("tutor_id = ? AND student_id = ?", current_tutor.id, params[:student_id].to_i)
    
    if !req.empty?
      Accepted.create({tutor_id: current_tutor.id, student_id: params[:student_id].to_i})
    end
    
    req.destroy_all
    flash[:success] = "Request Accepted"
    redirect_to requests_path
  end
  
  def index
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

  private
  
    def check_validity
      if (tutor_signed_in? && params[:tutor_id]) || (student_signed_in? && params[:student_id])
        flash[:danger] = "Invalid"
        redirect_to root_path
      end
    end
end
