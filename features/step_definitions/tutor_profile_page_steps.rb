
# Populate db
Given /the following tutors exist/ do |tutors|
  tutors.hashes.each do |tutor|
    FactoryGirl.create(:tutor, tutor)
  end
end

Then /^(?:|I |s?he )should (?:|also )see "(.*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I |s?he )should not see "(.*)"$/ do |text|
  expect(page).not_to have_content(text)
end

Given /^student named "([a-zA-Z]*) ([a-zA-Z]*)" is logged in$/ do |fname, lname|
  @student ||= FactoryGirl.create(:student, first_name: fname, last_name: lname)
  
  visit(new_student_session_path)
  fill_in "student_email", :with => @student.email
  fill_in "student_password", :with => "password"
  click_button "Log in"
end

Given /^a student named "([a-zA-Z]+) ([a-zA-Z]+)" exists$/ do |fname, lname|
  @student ||= FactoryGirl.create(:student, first_name: fname, last_name: lname)
end

Given /^([a-zA-Z]+) has a review with rating "([1-5])" from (?:him|her) saying "(.+)"$/ do |name, rating, comment|
  tutor = Tutor.find_by_name(name)
  Review.create!(student_id: @student.id, tutor_id: tutor.id, rating: rating, comment: comment)
end

When /^s?he selects "([1-5])" and comments "(.+)"$/ do |rating, comment|
  select rating.to_i, from: "Rating"
  fill_in "Comment", with: comment
  click_link_or_button "Submit Review"
end

When /^s?he is in ([a-zA-Z]+)'s student list$/ do |name|
  tutor = Tutor.find_by_name(name)
  Accepted.create!(student_id: @student.id, tutor_id: tutor.id)
end

When /^(?:|I |s?he )(?:am on|is on|visits?) tutor ([a-zA-Z]+)'s profile$/ do |name|
  tutor = Tutor.find_by_name(name)
  visit(tutor_path(tutor))
end

Then /^s?he should be on tutor ([a-zA-Z]+)'s profile$/ do |name|
  tutor = Tutor.find_by_name(name)
  expect(page).to have_current_path(tutor_path(tutor), only_path: true)
end

