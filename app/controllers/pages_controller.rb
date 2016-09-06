class PagesController < ApplicationController
  def home
    if admin_signed_in?
      redirect_to certificates_path
    elsif student_signed_in?
      @connected = current_student.accepted_tutors.first(4)
      @pending = current_student.pending_requests.first(4)
    elsif tutor_signed_in?
      @connected = current_tutor.accepted_students.first(4)
      @pending = current_tutor.student_requests.first(4)
    end
    
    @top_tutors = Tutor.order(avg: :desc).first(6)
  end

  def about
  end
  
  def contact
  end
  
  def search
    if params[:search]
      @tutors_found = Tutor.where("name LIKE ? OR email LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      @subject_tutors_found = []
      @subjects_found = Subject.joins(:tutor).where("subjects.name LIKE ?", "%#{params[:search]}%")
      # @subjects_found = Subject.where("subjects.name LIKE ?", "%#{params[:search]}%").includes(:tutor)
      @subjects_found.each do |s|
        @subject_tutors_found << s.tutor
      end
      
      @tutors_found = @tutors_found.to_a + @subject_tutors_found
    else
      @search_results = Tutor.all
    end
  end
  
  def filter
    @subjects = Subject.select("DISTINCT name")
  end
  
  def filtered_results
    @subject = Subject.where(name: params[:name])
    @tutors = []
    
    @subject.each do |s|
      @tutors << Tutor.find(s.tutor_id)      
    end
  end
end
