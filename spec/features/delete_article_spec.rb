require "rails_helper"

RSpec.feature "Deleting an article" do
  before do
    john = User.create!(email: "me@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "Article title", body: "Body of the article", user: john)
  end

  scenario "a user deletes an article" do
    visit "/"
    # click on Article link
    click_link @article.title
    # delete Article
    click_link "Delete Article"

    #### expextations ###
    # expect page to have succesfully deleted
    expect(page).to have_content("Article has been deleted")
    # expect path to be articles index page
    expect(current_path).to eq(articles_path)
  end
end
