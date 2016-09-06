require 'rails_helper'

def login_tutor
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:tutor]
    @tutor = FactoryGirl.create(:tutor)
    # student.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in @tutor
  end
end

RSpec.describe StudentsController do
  context "Logged in Tutor visits student profile" do
    login_tutor

    before(:each) { @student = FactoryGirl.create(:student) }
    
    it "checks for pending and accepted requests from the student being visited" do
      expect(Request).to receive(:pending?).with(@tutor.id, @student.id)
      expect(Accepted).to receive(:already_accepted?).with(@tutor.id, @student.id)
      get :show, id: @student.id, student_id: @student.id
    end
    
    it "@request_received is truthy if a request is pending from the student being visited" do
      FactoryGirl.create(:request, student_id: @student.id, tutor_id: @tutor.id)
      get :show, id: @student.id
      expect(assigns(:request_received)).to be_truthy
    end
    
    it "@request_received is falsey if request is pending from a different student" do
      FactoryGirl.create(:request, student_id: 100, tutor_id: @tutor.id)
      get :show, id: @student.id
      expect(assigns(:request_received)).to be_falsey
    end
    
    it "@request_accepted is truthy if the student is connected to the logged in tutor" do
      FactoryGirl.create(:accepted, student_id: @student.id, tutor_id: @tutor.id)
      get :show, id: @student.id
      expect(assigns(:request_accepted)).to be_truthy
    end
    
    it "@request_accepted is falsey if a different student is connected to the logged in tutor" do
      FactoryGirl.create(:accepted, student_id: 100, tutor_id: @tutor.id)
      get :show, id: @student.id
      expect(assigns(:request_accepted)).to be_falsey
    end
    
    it "collects all reviews written by the student" do
      review1 = FactoryGirl.create(:review, student_id: @student.id)
      review2 = FactoryGirl.create(:review, student_id: @student.id, tutor_id: 2)
      get :show, id: @student.id
      expect(assigns(:reviews)).to include(review1, review2)
    end
    
    it "Does not collect reviews of other students" do
      review = FactoryGirl.create(:review)
      get :show, id: @student.id
      expect(assigns(:reviews)).not_to include(review)
    end
    
    it "renders show" do
      get :show, id: @student.id
      expect(response).to render_template("students/show")
    end
  end
end