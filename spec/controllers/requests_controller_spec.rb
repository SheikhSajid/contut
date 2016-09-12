require 'rails_helper'

def login_tutor
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:tutor]
    @tutor = FactoryGirl.create(:tutor)
    # student.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in @tutor
  end
end
  
def login_student
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:student]
    @student = FactoryGirl.create(:student)
    # student.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in @student
  end
end

RSpec.describe RequestsController do
  context "no user logged in" do
    it "new request cannot be sent" do
      expect { post :create, tutor_id: 1, student_id: 1 }.to change(Request, :count).by(0)
    end
    
    it "redirects on create request" do
      get :create, tutor_id: 1, student_id: 1
      expect(response).to redirect_to(root_path)
    end
    
    it "redirects on index request" do
      get :index
      expect(response).to redirect_to(root_path)
    end
    
    it "redirects on destroy request" do
      get :destroy, id: 1, student_id: 1
      expect(response).to redirect_to(root_path)
    end
    
    it "redirects on accept request" do
      get :accept, tutor_id: 1, student_id: 1
      expect(response).to redirect_to(root_path)
    end
  end
  
  context "student logged in" do
    login_student
    let(:tutor) { FactoryGirl.create(:tutor) }
    
    it "new request can be sent as the logged student" do
      expect { post :create, tutor_id: 1 }.to change(Request, :count).by(1)
    end
    
    it "cannot accept requests" do
      expect { post :accept, student_id: @student.id }.to change(Accepted, :count).by(0)
    end
    
    it "redirects if student sends accept requests" do
      post :accept, student_id: @student.id
      expect(response).to redirect_to(root_path)
    end
    
    it "@pending is assigned the tutors who have pending requests sent by the logged in student" do
      FactoryGirl.create(:request, tutor_id: tutor.id, student_id: @student.id)
      get :index
      expect(assigns(:pending)).to include(tutor)
    end
    
    it "@pending is not assigned requests from other students" do
      FactoryGirl.create(:request, tutor_id: tutor.id, student_id: 100)
      get :index
      expect(assigns(:pending)).not_to include(tutor)
    end
    
    it "@accepted is assigned all tutors connected to the logged in student" do
      FactoryGirl.create(:accepted, tutor_id: tutor.id, student_id: @student.id)
      get :index
      expect(assigns(:accepted)).to include(tutor)
    end
    
    it "cannot see tutors connected to other students" do
      FactoryGirl.create(:accepted, tutor_id: tutor.id, student_id: 100)
      get :index
      expect(assigns(:accepted)).not_to include(tutor)
    end
  end
  
  context "tutor logged in" do
    login_tutor
    let(:student) { FactoryGirl.create(:student) }
    
    it "cannot send requests" do
      expect { post :create, tutor_id: @tutor.id, student_id: 1 }.to change(Request, :count).by(0)
    end
    
    it "number of requests decrease by 1 after valid accept request" do
      req = FactoryGirl.create(:request, tutor_id: @tutor.id)
      expect { post :accept, student_id: 100 }.to change(Request, :count).by(-1)
    end
    
    it "number of requests stays same after invalid accept request" do
      expect { post :accept, student_id: 100 }.to change(Accepted, :count).by(0)
    end
    
    it "number of accepteds increase by 1 after valid accept request" do
      FactoryGirl.create(:request, tutor_id: @tutor.id)
      expect { post :accept, student_id: 100 }.to change(Accepted, :count).by(1)
    end
    
    it "cannot accept requests for other tutors" do
      req = FactoryGirl.create(:request)
      expect { post :accept, student_id: req.student_id }.to change(Request, :count).by(0)
      # expect(response).to redirect_to(root_path)
    end
    
    it "can see own pending requests" do
      pending_req = FactoryGirl.create(:request, tutor_id: @tutor.id, student_id: student.id)
      get :index
      expect(assigns(:pending)).to include(student)
    end
    
    it "cannot see pending requests for other tutors" do
      pending = FactoryGirl.create(:request, tutor_id: 100, student_id: student.id)
      get :index
      expect(assigns(:pending)).not_to include(student)
    end
    
    it "can see students connected to himself/herself" do
      accepted = FactoryGirl.create(:accepted, tutor_id: @tutor.id, student_id: student.id)
      get :index
      expect(assigns(:accepted)).to include(student)
    end
    
    it "cannot see students not connected to him but connected to others" do
      accepted = FactoryGirl.create(:accepted, tutor_id: 100, student_id: student.id)
      get :index
      expect(assigns(:accepted)).not_to include(student)
    end
    
    it "can decline requests" do
      req = FactoryGirl.create(:request, tutor_id: @tutor.id)
      expect { delete :destroy, id: -1, student_id: req.student_id }.to change(Request, :count).by(-1)
    end
  end
end