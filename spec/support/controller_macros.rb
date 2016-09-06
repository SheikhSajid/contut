module ControllerMacros
#   def login_admin
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:admin]
#       sign_in FactoryGirl.create(:admin) # Using factory girl as an example
#     end
#   end

  def login_student
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      student = FactoryGirl.create(:student)
      # student.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in student
    end
  end
end