
# Populate db
Given /the following tutors exist/ do |tutors_table|
  tutors_table.hashes.each do |tutor|
    # visit(new_tutor_session)
    tut = Tutor.new(tutor)
    tut.skip_confirmation!
    tut.save!
  end
end

Then /^(?:|I ) should see "(.*)"$/ do |text|
  expect(page).to have_content(text)
end

When /^(?:|I ) am on tutor (.+)'s profile$/ do |name|
  tutor = Tutor.find_by_name(name)
  visit(tutor_path(tutor))
end

