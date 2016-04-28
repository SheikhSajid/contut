class TutorsController < ApplicationController
  before_action :set_tutor, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @tutors = Tutor.all
  end

  def show
  end

  def new
    @tutor = Tutor.new
  end

  def edit
  end

  def create
    @tutor = Tutor.new(tutor_params)

    if Student.find_by(email: @tutor.email)
      flash.now[:danger] = "email already in use"
      render :new
    elsif @tutor.save
      flash[:notice] = "You have successfully registered as a tutor"
      redirect_to tutor_path(@tutor)
    else
      render :new
    end
  end

  def update
    if @tutor.update(tutor_params)
      flash[:notice] = "Profile updated"
      redirect_to tutor_path(@tutor)
    else
      render :edit
    end
  end

  def destroy
    @tutor.destroy
    flash[:notice] = "Profile deleted"
    redirect_to root_path
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params.require(:tutor).permit(:fname, :lname, :email, :password, :password_confirmation, :gender, :curr_employer, :position, :rate, :description, :city, :area, :zip, :full_address, :rating)
    end
    
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end
    
    def require_same_user
      if @tutor != current_user
        flash[:danger] = "Unauthorized access"
        redirect_to root_path
      end
    end
end
