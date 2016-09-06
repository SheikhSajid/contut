class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show]
  
  # before_action :authenticate_tutor!, only: [:edit, :update, :destroy]
  
  def index
    @tutors = Tutor.all
  end

  def show
    # @reviews = Review.where(tutor_id: @tutor.id).order(created_at: :desc)
    @reviews = @tutor.reviews.order(created_at: :desc)
    @subjects = @tutor.subjects
    
    @request_sent = false
    @request_accepted = false
    
    if student_signed_in?
      @request_sent = Request.pending? params[:id], current_student.id
      @request_accepted = Accepted.where("tutor_id = ? AND student_id = ?", params[:id], current_student.id)
      
      if @request_accepted.any?
        @time_since_accepted = Time.now - @request_accepted.first.created_at
      end
    end
  end
  
  # def new
  #   @tutor = Tutor.new
  # end

  # def edit
  # end

  # def create
  #   @tutor = Tutor.new(tutor_params)
  #   # @tutor.fname.capitalize!
  #   # @tutor.lname.capitalize!
    
  #   if Student.find_by(email: @tutor.email)
  #     flash.now[:danger] = "email already in use"
  #     render :new
  #   elsif @tutor.save
  #     session[:tutor_id] = @tutor.id
  #     flash[:success] = "You have successfully registered as a tutor"
  #     redirect_to tutor_path(@tutor)
  #   else
  #     render :new
  #   end
  # end

  # def update
  #   if @tutor.update(tutor_params)
  #     flash[:notice] = "Profile updated"
  #     redirect_to tutor_path(@tutor)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @tutor.destroy
  #   flash[:notice] = "Profile deleted"
  #   redirect_to root_path
  # end
  
  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    # def tutor_params
    #   params.require(:tutor).permit(:fname, :lname, :email, :password, :password_confirmation,
    #                                 :gender, :rate, :description,
    #                                 :city, :area, :zip, :full_address, :rating, :profile_picture,
    #                                 :phone, :degree, :institution, :year)
    # end
    
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end
    
    # def require_same_user
    #   if @tutor != current_user
    #     flash[:danger] = "Unauthorized access"
    #     redirect_to root_path
    #   end
    # end
end
