Given /^I sign in through facebook$/ do
  visit 'students/auth/facebook'
end

# Then /^I should be on ()'s profile$/ do |first_name|
#   student = Student.find_by_first_name(first_name)
#   current_path = URI.parse(current_url).path
#   expect(current_path).to eql(student_path(student))
# end