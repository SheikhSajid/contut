class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
  end

  def show
    @reviews = @student.reviews.order(created_at: :desc)
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    # @student.first_name.capitalize!
    # @student.last_name.capitalize!
    if Tutor.find_by(email: @student.email)
      flash.now[:danger] = "email already in use"
      render :new
    elsif @student.save
      session[:student_id] = @student.id
      flash[:success] = "You have successfully registered as a student"
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
    @student.destroy
    flash[:notice] = "Profile deleted"
    redirect_to root_path
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :phone, :password,
                                      :password_confirmation, :gender, :city, :area, :zip,
                                      :full_address, :profile_picture)
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
