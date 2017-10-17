Given(/^I am on the login page$/) do
  visit login_url
end

When(/^I login$/) do
  fill_in 'session[email]', with: 'user@user.user'
  fill_in 'session[password]', with: 'password'
  click_button 'Login'
end

Then(/^I am taken to my profile$/) do
  expect(page).to have_content 'user@user.user'
end
