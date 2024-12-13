require 'rails_helper'

RSpec.describe "Movies", type: :system do
  # it "should return the movies" do
  #   visit "/movies"
  #   expect(page).to have_content("Title", count: 100)
  #   expect(page).to have_content("sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
  # end

  it "should fetch the movies", js: true do
    visit "/movies"
    puts page.html
    click_on "Fetch movies"
    # sleep(10)
    expect(page).to have_content("100")
  end

  # it "should return the movies"
end
