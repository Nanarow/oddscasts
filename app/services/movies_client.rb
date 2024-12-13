require "httparty"

class MoviesClient
  include HTTParty
  base_uri "https://jsonplaceholder.typicode.com"

  def self.get_movies
    get("/posts")
  end

  def self.base_uri=(uri)
    @base_uri = uri
  end
end
