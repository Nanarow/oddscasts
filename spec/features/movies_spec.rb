require 'rails_helper'
require 'webmock/rspec'
require 'spec_helper'

RSpec.describe "Movies", type: :feature do
  it "should return the movies" do
    response = MoviesClient.get_movies
    expect(response.code).to eq(200)
    expect(response.first["title"]).to eq("sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
  end
end
