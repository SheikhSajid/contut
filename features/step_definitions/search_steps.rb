
When /^I put "(.+)" in the search bar$/ do |search_term|
  visit(root_path)
  fill_in "search", with: search_term
  click_button "search-button"
end

Given /^([a-zA-Z]+) teaches "([a-zA-Z]+)"$/ do |name, subject|
  tutor = Tutor.find_by_name(name)
  Subject.create!(tutor_id: tutor.id, name: subject, grade: 4)
end
