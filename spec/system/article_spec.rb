require 'rails_helper'

describe "Articles Management", type: :system do
  let!(:articles) { create_list(:article, 4) }
  let(:article) { create(:article, title: "Article 1", description: "Article Description 1") }

  scenario "User views all articles" do
    visit_articles_page
    expect_articles_to_be_displayed
  end

  scenario "User creates a new article" do
    visit_new_article_page
    fill_in_article_form
    attach_article_cover
    submit_article_create_form
    expect_article_to_be_created
  end

  scenario "User edits an article" do
    visit_edit_article_page
    fill_in_updated_article_details
    submit_article_update_form
    expect_article_to_be_updated
  end

  scenario "User deletes an article" do
    visit_articles_page
    visit_article_details_page
    delete_article
    expect_article_to_be_deleted
  end

  private

  def visit_new_article_page
    visit new_article_path
  end

  def visit_edit_article_page
    visit edit_article_path(article)
  end

  def visit_articles_page
    visit articles_path
  end

  def visit_article_details_page
    visit article_path(article)
  end

  def fill_in_article_form
    fill_in "Title", with: article.title
    fill_in "Description", with: article.description
  end

  def attach_article_cover
    attach_file "Cover", "./spec/fixtures/cover.png"
  end

  def fill_in_updated_article_details
    fill_in "Title", with: "Updated Article"
    fill_in "Description", with: "Updated description of the article"
  end

  def submit_article_create_form
    click_on "Create Article"
  end

  def submit_article_update_form
    click_on "Update Article"
  end

  def delete_article
    click_on "Destroy this article"
  end

  def expect_article_to_be_created
    expect(page).to have_content("Article was successfully created.")
    expect(page).to have_content(article.title)
    expect(page).to have_content(article.description)
    expect(page).to have_content("cover.png")
  end

  def expect_article_to_be_updated
    expect(page).to have_content("Article was successfully updated.")
  end

  def expect_article_to_be_deleted
    expect(page).to have_content("Article was successfully destroyed.")
  end

  def expect_articles_to_be_displayed
    expect(page).to have_content("Show this article", count: 4)
  end
end
