class PagesController < ApplicationController
  def home
  end

  def about
  end
  
  def contact
  end
  
  def signup
    if logged_in?
      flash[:success] = "You are already logged in as a user. Please log out to add a new user."
      redirect_to root_path
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
