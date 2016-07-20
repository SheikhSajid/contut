class MessagesController < ApplicationController
  before_action :signed_in?
  
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    
    if @message.save
      if student_signed_in?
        redirect_to feed_path({tutor_id: @message.tutor_id})
      elsif tutor_signed_in?
        redirect_to feed_path({student_id: @message.student_id})
      end
    else
      flash[:danger] = "Message not sent.Oops!"
      redirect_to root_path
    end
  end
  
  def mymessages
    if tutor_signed_in?
      @senders = Message.where(tutor_id: current_tutor.id)
      @senders = @senders.select("DISTINCT student_id")
    elsif student_signed_in?
      @senders = Message.where(student_id: current_student.id)
      @senders = @senders.select("DISTINCT tutor_id")
    end
  end
  
  def feed
    if tutor_signed_in?
      @messages = Message.where("student_id = ? AND tutor_id = ?", params[:student_id],
                                                                   current_tutor.id)
      @sender = Student.find(params[:student_id])
    elsif student_signed_in?
      @messages = Message.where("student_id = ? AND tutor_id = ?", current_student.id,
                                                                   params[:tutor_id])
      @sender = Tutor.find(params[:tutor_id])
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message, :sender_tutor, :sender_student,
                                                :tutor_id, :student_id)
    end
    
    def signed_in?
      tutor_signed_in? or student_signed_in?
    end
end
