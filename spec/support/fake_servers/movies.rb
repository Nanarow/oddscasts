require 'sinatra/base'

class FakeMoviesClient < Sinatra::Base
  before do
    headers 'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => [ 'OPTIONS', 'GET', 'POST' ]
  end

  get '/posts' do
    puts "hit get /posts"
    json_response 200, 'movies.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.read(File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'responses', file_name))
  end
end
