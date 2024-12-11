require "rails_helper"

RSpec.shared_examples "Contents", type: :system do
  scenario "User views all contents" do
    visit_contents_page
    expect_contents_to_be_displayed
  end

  scenario "User creates a new content" do
    visit_new_content_page
    fill_in_content_form
    submit_content_create_form
    expect_content_to_be_created
  end

  scenario "User submits content for review" do
    visit_content_details_page
    click_submit_content_for_review
    expect_content_to_be_submitted_for_review
  end

  scenario "User approves content" do
    visit_content_details_page
    click_approve_content
    expect_content_to_be_approved
  end

  scenario "User rejects content" do
    visit_content_details_page
    click_reject_content
    expect_content_to_be_rejected
  end

  scenario "User edits an content" do
    visit_edit_content_page
    fill_in_updated_content_details
    submit_content_update_form
    expect_content_to_be_updated
  end

  scenario "User deletes an content" do
    visit_contents_page
    visit_content_details_page
    delete_content
    expect_content_to_be_deleted
  end

  private

  def visit_new_content_page
    visit "admin"
    click_on contentable
    click_on "New"
  end

  def visit_edit_content_page
    visit "admin"
    click_on contentable
    all("a", text: "Show this").last.click
    click_on "Edit"
  end

  def visit_contents_page
    visit "admin"
    click_on contentable
  end

  def visit_content_details_page
    visit "admin"
    click_on contentable
    all("a", text: "Show this").last.click
  end

  def fill_in_content_form
    fill_in "Title", with: content.title
    fill_in "Description", with: content.description
  end

  # def attach_content_cover
  #   attach_file "Cover", "./spec/fixtures/cover.png"
  # end

  def fill_in_updated_content_details
    fill_in "Title", with: "Updated"
    fill_in "Description", with: "Updated description of the content"
  end

  def submit_content_create_form
    click_on "Create"
  end

  def submit_content_update_form
    click_on "Update"
  end

  def delete_content
    click_on "Destroy"
  end

  def expect_content_to_be_created
    expect(page).to have_content("successfully created.")
    expect(page).to have_content(content.title)
    expect(page).to have_content(content.description)
    expect(page).to have_content("draft")
  end

  def expect_content_to_be_updated
    expect(page).to have_content("successfully updated.")
  end

  def expect_content_to_be_deleted
    expect(page).to have_content("successfully destroyed.")
  end

  def expect_contents_to_be_displayed
    expect(page).to have_content("Show this", count: contents.length)
  end

  def click_submit_content_for_review
    click_on "Submit for review"
  end

  def expect_content_to_be_submitted_for_review
    expect(page).to have_content("successfully updated.")
    expect(page).to have_content("in_review")
  end

  def click_approve_content
    click_on "Approve"
  end

  def expect_content_to_be_approved
    expect(page).to have_content("successfully updated.")
    expect(page).to have_content("published")
  end

  def click_reject_content
    click_on "Reject"
  end

  def expect_content_to_be_rejected
    expect(page).to have_content("successfully updated.")
    expect(page).to have_content("draft")
  end
end
