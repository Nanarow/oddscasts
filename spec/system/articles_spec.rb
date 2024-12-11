require "rails_helper"

describe "Articles Management", type: :system do
  it_should_behave_like "Contents" do
    let(:contentable) { "Articles" }
    let(:content) { article }
    let(:contents) { articles }
  end

  let(:article) { create(:article, title: "Article 1", description: "Article Description 1") }
  let!(:articles) { create_list(:article, 4) }
end
