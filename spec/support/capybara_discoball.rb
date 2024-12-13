require_relative "fake_servers/movies"
require_relative "../../app/services/movies"

FakeMoviesClientRunner = Capybara::Discoball::Runner.new(FakeMoviesClient) do |server|
  puts "Fake server started at #{server.url}"
  Movies.uri = "#{server.url}/posts"
end

FakeMoviesClientRunner.boot
