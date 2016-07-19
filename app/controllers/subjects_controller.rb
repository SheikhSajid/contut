class SubjectsController < ApplicationController
  before_action :set_subject, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:new, :edit, :destroy]
  # before_action :require_user, only: [:new, :create]
  
  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    # @subject.tutor_id = @tutor.id
    @subject.name.capitalize!
    if @subject.save
      flash[:success] = "Profile updated!"
    else
      flash[:danger] = "Error"
    end
    
    redirect_to tutor_path(@subject.tutor_id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name, :grade, :tutor_id)
    end
    
    def set_subject
      @subject = Subject.find(params[:id])
    end
    
    def set_tutor
      if params[:tutor_id]
        @tutor = Tutor.find(params[:tutor_id])
        return true
      else
        return false
      end
    end
    
    def require_same_user
      if params[:tutor_id].to_i != current_tutor.id
        flash[:danger] = "Unauthorized access"
        redirect_to root_path
      end
    end
end
