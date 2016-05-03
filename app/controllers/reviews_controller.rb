class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_tutor
  before_action :require_student, only: [:new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.student_id = current_user.id
    @review.tutor_id = @tutor.id
    
    if @review.save
      redirect_to @tutor
    else
      flash[:danger] = "Comment could not be added"
      redirect_to @tutor
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to @tutor
  end

  def destroy
    @review.destroy
    redirect_to @tutor
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    
    def set_review
      @review = Review.find(params[:id])
    end
    
    def set_tutor
      @tutor = Tutor.find(params[:tutor_id])
    end
    
    def require_same_user
      if @review.student_id != session[:student_id]
        flash[:danger] = "Oops! You are not allowed to do that."
        redirect_to root_path
      end
    end
end
