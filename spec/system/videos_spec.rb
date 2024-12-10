require 'rails_helper'

describe "Videos Management", type: :system do
  let!(:videos) { create_list(:video, 4) }
  let(:video) { create(:video, title: "Video 1", description: "Video Description 1") }

  scenario "User views all videos" do
    visit_videos_page
    expect_videos_to_be_displayed
  end

  scenario "User creates a new video" do
    visit_new_video_page
    fill_in_video_form
    attach_video_cover
    submit_video_create_form
    expect_video_to_be_created
  end

  scenario "User edits an video" do
    visit_edit_video_page
    fill_in_updated_video_details
    submit_video_update_form
    expect_video_to_be_updated
  end

  scenario "User deletes an video" do
    visit_videos_page
    visit_video_details_page
    delete_video
    expect_video_to_be_deleted
  end

  private

  def visit_new_video_page
    visit new_video_path
  end

  def visit_edit_video_page
    visit edit_video_path(video)
  end

  def visit_videos_page
    visit videos_path
  end

  def visit_video_details_page
    visit video_path(video)
  end

  def fill_in_video_form
    fill_in "Title", with: video.title
    fill_in "Description", with: video.description
  end

  def attach_video_cover
    attach_file "Cover", "./spec/fixtures/cover.png"
  end

  def fill_in_updated_video_details
    fill_in "Title", with: "Updated Video"
    fill_in "Description", with: "Updated description of the video"
  end

  def submit_video_create_form
    click_on "Create Video"
  end

  def submit_video_update_form
    click_on "Update Video"
  end

  def delete_video
    click_on "Destroy this video"
  end

  def expect_video_to_be_created
    expect(page).to have_content("Video was successfully created.")
    expect(page).to have_content(video.title)
    expect(page).to have_content(video.description)
    expect(page).to have_content("cover.png")
  end

  def expect_video_to_be_updated
    expect(page).to have_content("Video was successfully updated.")
  end

  def expect_video_to_be_deleted
    expect(page).to have_content("Video was successfully destroyed.")
  end

  def expect_videos_to_be_displayed
    expect(page).to have_content("Show this video", count: 4)
  end
end
