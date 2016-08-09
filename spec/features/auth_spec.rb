require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    before(:each) do
      visit new_user_url
      fill_in "Username", :with => "Davin123"
      fill_in "Password", :with => "123456"
      click_on "Sign Up"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "Davin123"
    end

    scenario "redirects to user home page" do
      expect(page).to have_content "My Goals"
    end
  end

  feature "signing up with invalid params" do

    scenario "redirects to user signup page" do

      visit new_user_url
      fill_in "Username", :with => "Dav"
      fill_in "Password", :with => "1234"
      click_on "Sign Up"

      expect(page).to have_content "Sign Up"
    end
  end


end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    visit new_session_url
    expect(page).to have_content "Sign In"
  end

end

feature "logging out" do

  before(:each) do
    visit new_user_url
    fill_in "Username", :with => "Davin123"
    fill_in "Password", :with => "123456"
    click_on "Sign Up"
  end

  scenario "begins with a logged out state" do
    expect(page).to have_button "Sign Out"
  end

  scenario "doesn't show username on the homepage after logout" do
    click_on "Sign Out"
    expect(page).to have_content "Sign In"
  end

end
