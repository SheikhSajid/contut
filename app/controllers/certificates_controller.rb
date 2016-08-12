class CertificatesController < ApplicationController
  before_action :admin_signed_in?, only: [:index, :approve, :decline]
  before_action :tutor_signed_in?, only: [:new, :create]
  before_action :authorized?, only: [:destroy]
  
  def new
    @certificate = Certificate.new
  end
  
  def create
    @certificate = Certificate.new(certificate_params)
    @certificate.tutor_id = current_tutor.id
    
    if @certificate.save
      Tutor.find(current_tutor.id).update(pending_approval: true)
      flash[:success] = "Certificate added. An admin will review your certificate very soon."
      redirect_to current_tutor
    else
      flash[:danger] = "Certificate could not be added"
      redirect_to current_tutor
    end  
  end
  
  def index
    @tutors = Tutor.where(pending_approval: true).includes(:certificates)
  end
  
  def approve
    @certificate = Certificate.find(params[:id])
    
    @certificate.tutor.update(approved: true, pending_approval: false)
    
    @certificate.destroy
    redirect_to root_path
  end
  
  def decline
    @certificate = Certificate.find(params[:id])
    @certificate.tutor.update(pending_approval: false)
    @certificate.destroy
    redirect_to root_path
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def certificate_params
      params.require(:certificate).permit(:photo)
    end
    
    def authorized?
      return (tutor_signed_in? || admin_signed_in?)
    end
end
