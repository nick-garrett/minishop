Given(/^I am logged in$/) do
  visit login_url
  fill_in 'session[email]', with: 'user@user.user'
  fill_in 'session[password]', with: 'password'
  click_button 'Login'
end

When(/^I logout$/) do
  click_link 'Logout'
end

Then(/^I am logged out$/) do
  expect(page).not_to have_content 'Profile'
end
