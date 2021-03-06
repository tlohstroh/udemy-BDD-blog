require "rails_helper"

RSpec.feature "Signing out signed-in users" do
  # this is about a signed in user, so we need to create a user first!
  # we also need to sign this user in first!!!
  before do
    @tjitske = User.create!(email: "tjitske@example.com", password: "password")
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @tjitske.email
    fill_in "Password", with: @tjitske.password
    click_button "Log in"
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")
  end
end
