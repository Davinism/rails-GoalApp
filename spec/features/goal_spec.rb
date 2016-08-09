require 'rails_helper'

feature "the creating a new goal process" do
  before(:each) do
    visit new_user_url
    fill_in "Username", :with => "Davin123"
    fill_in "Password", :with => "123456"
    click_on "Sign Up"
    click_on "New Goal"
  end

  scenario "shows the new goal page" do
    expect(page).to have_content "New Goal"
  end

  feature "creating a new goal" do
    scenario "creating with invalid params" do
      fill_in "Description", :with => "I want to get taller."
      click_on "Add Goal"

      expect(page).to have_content "New Goal"
    end

    scenario "creating with valid params" do
      fill_in "Description", :with => "I want to get taller."
      save_and_open_page
      choose "Private"
      fill_in "Progress", :with => 36
      click_on "Add Goal"

      expect(page).to have_content "My Goals"
    end
  end
end
