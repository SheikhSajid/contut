class PagesController < ApplicationController
  def home
  end

  def about
  end
  
  def signup
    if logged_in?
      flash[:success] = "You are already logged in as a user. Please log out to add a new user."
      redirect_to root_path
    end
  end
end
