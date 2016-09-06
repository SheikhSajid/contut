class StudentsController < ApplicationController
  before_action :set_student, only: [:show]
  # before_action :require_connection, only: [:show]

  def index
  end

  def show
    @reviews = @student.reviews.order(created_at: :desc)
    @request_received = false
    @request_accepted = false
    
    if tutor_signed_in?
      @request_received = Request.pending? current_tutor.id, params[:id].to_i
      @request_accepted = Accepted.already_accepted? current_tutor.id, params[:id].to_i
    end
  end
  


  # def new
  #   @student = Student.new
  # end

  # def edit
  # end

  # def create
  #   @student = Student.new(student_params)
  #   if Tutor.find_by(email: @student.email)
  #     flash.now[:danger] = "email already in use"
  #     render :new
  #   elsif @student.save
  #     session[:student_id] = @student.id
  #     flash[:success] = "You have successfully registered as a student"
  #     redirect_to student_path(@student)
  #   else
  #     flash.now[:danger] = "Something happened."
  #     render :new
  #   end
  # end

  # def update
  #   if @student.update(student_params)
  #     flash[:success] = "Profile updated"
  #     redirect_to student_path(@student)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @student.destroy
  #   flash[:danger] = "Profile deleted"
  #   redirect_to root_path
  # end
  
  private
    def set_student
      @student = Student.find(params[:id])
    end
    
    # def require_connection
    #   if !(student_signed_in? && current_student.id == params[:id])
    #     flash[:notice] = "You can view student profiles only if you are connected to that student as a Tutor"
    #     redirect_to root_path
    #   elsif !(tutor_signed_in? && (Request.pending?(current_tutor.id, params[:id]) || Accepted.already_accepted?(current_tutor.id, params[:id])))
    #     flash[:notice] = "You can view student profiles only if you are connected to that student as a Tutor"
    #     redirect_to root_path
    #   end  
    # end
end
