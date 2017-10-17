Given(/^I am an admin$/) do
  visit login_url
  fill_in 'session[email]', with: 'admin@admin.admin'
  fill_in 'session[password]', with: 'administrator'
  click_button 'Login'
end

Given(/^I am on the users page$/) do
  visit users_url
end

When(/^I validate a user$/) do
  click_button 'Validate User'
end

Then(/^the user is validated$/) do
  expect(page).to have_content('Has been validated')
end
