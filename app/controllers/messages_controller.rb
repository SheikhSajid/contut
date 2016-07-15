class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    
    if @message.save
      if session[:student_id]
        redirect_to feed_path({tutor_id: @message.tutor_id})
      elsif session[:tutor_id]
        redirect_to feed_path({student_id: @message.student_id})
      end
    else
      flash[:danger] = "Message not sent.Oops!"
      redirect_to root_path
    end
  end
  
  def mymessages
    if session[:tutor_id]
      @senders = Message.where(tutor_id: session[:tutor_id])
      @senders = @senders.select("DISTINCT student_id")
    elsif session[:student_id]
      @senders = Message.where(student_id: session[:student_id])
      @senders = @senders.select("DISTINCT tutor_id")
    end
  end
  
  def feed
    if session[:tutor_id]
      @messages = Message.where("student_id = ? AND tutor_id = ?", params[:student_id],
                                                                   session[:tutor_id])
      @sender = Student.find(params[:student_id])
    elsif session[:student_id]
      @messages = Message.where("student_id = ? AND tutor_id = ?", session[:student_id],
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
end
