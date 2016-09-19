Given /^I am on the homepage$/ do
  visit(root_path)
end

Given /^tutor (.+) is logged in$/ do |name|
  tutor = Tutor.find_by_name(name)
  visit(new_tutor_session_path)
  fill_in "tutor_email", :with => tutor.email
  fill_in "tutor_password", :with => "passwrd"
  click_button "Log in"
end

When /^(?:|I |s?he )clicks? on "(.+)"$/ do |link|
  click_link_or_button link
end

Then /^I should be (?:taken to|on) (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eql(path_to(page_name))
end

