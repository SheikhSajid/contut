FactoryGirl.define do
  factory :student do
    first_name "John"
    last_name "Doe"
    sequence(:email) { |n| "#{first_name}.#{last_name}#{n}@example.com".downcase }
    city "Dhaka"
    area "Mirpur"
    zip 1216
    full_address "Eastern Housing, Duaripara, Mirpur, Dhaka"
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
  
  factory :tutor do
    name "Teacher"
    rate 5000
    sequence(:email) { |n| "#{name}#{n}@teacher.com".downcase }
    city "Dhaka"
    area "Mirpur"
    zip 1216
    full_address "Eastern Housing, Duaripara, Mirpur, Dhaka"
    password "password"
    password_confirmation "password"
    degree "MSc"
    institution "BRAC University"
    year "2017"
    confirmed_at Date.today
    no_of_reviews 0
    avg 0.0
  end
  
  factory :request do
    tutor_id 100
    student_id 100
  end
  
  factory :accepted do
    tutor_id 100
    student_id 100
  end
  
  factory :review do
    rating 5
    tutor_id 100
    student_id 100
    comment "excellent"
  end
end