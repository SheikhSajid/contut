class TutorsController < ApplicationController
  def index
    @tutors = Tutor.all
  end

  def show
    @tutor = Tutor.find(params[:id])
  end

  def new
    @tutor = Tutor.new
  end

  def edit
    @tutor = Tutor.find(params[:id])
  end

  def create
    @tutor = Tutor.new(tutor_params)

    if @tutor.save
      flash[:notice] = "You have successfully registered as a tutor"
      redirect_to tutor_path(@tutor)
    else
      render :new
    end
  end

  def update
    @tutor = Tutor.find(params[:id])
    
    if @tutor.update(tutor_params)
      flash[:notice] = "Profile updated"
      redirect_to tutor_path(@tutor)
    else
      render :edit
    end
  end

  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy
    flash[:notice] = "Profile deleted"
    redirect_to root_path
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params.require(:tutor).permit(:fname, :lname, :email, :password, :password_confirmation, :gender, :curr_employer, :position, :rate, :description, :city, :area, :zip, :full_address, :rating)
    end
end
