require "rails_helper"

RSpec.feature "Creating Articles" do

  before do
    @john = User.create!(email: "me@example.com", password: "password")
    login_as(@john)
  end


  scenario "A user creates a new article" do
    # visit root page
    visit "/"
    # click on new Article
    click_link "New Article"
    # fill in title
    fill_in "Title", with: "Creating a blog"
    # fill in body
    fill_in "Body", with: "Lorem Ipsum"
    # create Article
    click_button "Create Article"

    #### expextations ###
    expect(Article.last.user).to eq(@john)
    # Article has been created
    expect(page).to have_content("Article has been created")
    # articles path
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@john.email}")
  end

  scenario "A user fails to create a new article" do
    visit "/"
    click_link "New Article"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Article"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
