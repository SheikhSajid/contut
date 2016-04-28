class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @student = Student.new
  end

  def edit
    if @student != current_user
      flash
    end
  end

  def create
    @student = Student.new(student_params)
    
    if Tutor.find_by(email: @student.email)
      flash.now[:danger] = "email already in use"
      render :new
    elsif @student.save
      flash[:notice] = "You have successfully registered as a student"
      redirect_to student_path(@student)
    else
      render :new
    end
  end

  def update
    if @student.update(student_params)
      flash[:notice] = "Profile updated"
      redirect_to student_path(@student)
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    flash[:notice] = "Profile deleted"
    redirect_to root_path
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :gender, :city, :area, :zip, :full_address)
    end
    
    def set_student
      @student = Student.find(params[:id])
    end
    
    def require_same_user
      if @student != current_user
        flash[:danger] = "Unauthorized access"
        redirect_to root_path
      end
    end
end
