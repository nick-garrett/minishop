When(/^I delete a user$/) do
  click_button 'Delete User'
end

Then(/^the user is deleted$/) do
  expect(page).not_to have_content('user@user.user')
end
