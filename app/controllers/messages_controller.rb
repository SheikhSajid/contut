class MessagesController < ApplicationController
  before_action :signed_in?
  
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    
    respond_to do |format|
      if @message.save
        format.js
      else
        flash[:danger] = "Message not sent.Oops!"
        redirect_to root_path
      end
    end
  end
  
  def mymessages
    if tutor_signed_in?
      @messages = Message.includes(:student).where(tutor_id: current_tutor.id).select("DISTINCT student_id")
    elsif student_signed_in?
      @messages = Message.includes(:tutor).where(student_id: current_student.id).select("DISTINCT tutor_id")
    end
  end
  
  def index
    if tutor_signed_in?
      @messages = Message.includes(:student).where("student_id = ? AND tutor_id = ? AND id > ?", params[:student_id],
                                                                   current_tutor.id, params[:after_id])
    elsif student_signed_in?
      @messages = Message.includes(:tutor).where("student_id = ? AND tutor_id = ? AND id > ?", current_student.id,
                                                                   params[:tutor_id], params[:after_id])
    end
    
    @message = Message.new
    
    respond_to do |format|
      format.html
      format.js {render :layout => false }
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message, :sender_tutor, :sender_student,
                                                :tutor_id, :student_id)
    end
end
