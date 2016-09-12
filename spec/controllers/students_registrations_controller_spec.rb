require 'rails_helper'

def login_student
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:student]
    @student = FactoryGirl.create(:student)
    # student.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in @student
  end
end

RSpec.describe Students::RegistrationsController do
  context "Student logged in" do
    login_student
    
    describe "edit profile request" do
      it "renders edit.html.erb" do
        get :edit, id: @student.id
        expect(response).to render_template("students/registrations/edit")
      end
    end
    
    describe "form submission" do
      before(:each) do
        @updated_attributes = FactoryGirl.attributes_for(:student, :first_name => "New", :last_name => "Name", :current_password => "password" )
        put :update, { :id => @student.id, :student => @updated_attributes }
        @student.reload
      end
      
      it { expect(response).to redirect_to(root_path) }
      it { expect(@student.first_name).to eql "New" }
      it { expect(@student.last_name).to eql "Name" }
    end
  end
  
  context "Not logged in" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      @student = FactoryGirl.create(:student)
      @updated_attributes = FactoryGirl.attributes_for(:student, :first_name => "New", :last_name => "Name", :current_password => "password" )
      
      put :update, { :id => @student.id, :student => @updated_attributes }
      
      @student.reload
    end
    
    it { expect(response).to redirect_to(new_student_session_path) }
    it { expect(@student.first_name).to eql "John" }
    it { expect(@student.last_name).to eql "Doe" }
  end
end