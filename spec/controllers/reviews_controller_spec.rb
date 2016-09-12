require 'rails_helper'

def login_student
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:student]
    @student = FactoryGirl.create(:student)
    # student.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in @student
  end
end

RSpec.describe ReviewsController do
  before(:each) do
    @tutor = FactoryGirl.create(:tutor, no_of_reviews: 1, avg: 4)
  end
  
  context "no user logged in" do
    it "new review form request leads to a redirect" do
      get :new, tutor_id: @tutor.id
      expect(response).to redirect_to(root_path)
    end
    
    it "create request redults in redirect" do
      get :create, tutor_id: @tutor.id, review: { :rating => 5, :comment => "Bogus Review" }
      expect(response).to redirect_to(root_path)
    end
    
    it "delete request results in redirect" do
      review = FactoryGirl.create(:review)
      delete :destroy, id: review.id, tutor_id: @tutor.id
      expect(response).to redirect_to(root_path)
    end
  end
  
  context "student logged in" do
    login_student
    
    it "review can be created" do
      expect {
        get :create, tutor_id: @tutor.id, review: { rating: 5, comment: "Bogus Review" }
      }.to change(Review, :count).by(1)
    end
    
    describe "edit action" do
      it "review written by other students" do
        review = FactoryGirl.create(:review, tutor_id: @tutor.id)
        get :edit, id: review.id, tutor_id: @tutor.id
        expect(response).to redirect_to(root_path)
      end
      
      it "review written by logged in student" do
        review = FactoryGirl.create(:review, tutor_id: @tutor.id, student_id: @student.id)
        get :edit, id: review.id, tutor_id: @tutor.id
        expect(response).to render_template(:edit)
      end
    end
    
    describe "update action" do
      it "can update own reviews" do
        review = FactoryGirl.create(:review, tutor_id: @tutor.id, student_id: @student.id)
        put :update, id: review.id, tutor_id: @tutor.id, review: { rating: 1, comment: "Disgusting" }
        review.reload
        expect(review.rating).to eql(1)
        expect(review.comment).to eql("Disgusting")
      end
      
    end
    
    
    describe "tutor's no_of_reviews and avg fields are updated" do
      before(:each) do
        get :create, tutor_id: @tutor.id, review: { rating: 5, comment: "Bogus Review" }
        @tutor.reload
      end
      
      it "adds 1 to the no_of_reviews field of the tutor" do
        expect(@tutor.no_of_reviews).to eq(2)
      end
      
      it "tutor's avg field gets updated" do
        expect(@tutor.avg).to eq(4.5)
      end
    end
    
    it "can delete review" do
      review = FactoryGirl.create(:review, student_id: @student.id)
      expect {
        delete :destroy, id: review.id, tutor_id: @tutor.id
      }.to change(Review, :count).by(-1)
    end
  end
end