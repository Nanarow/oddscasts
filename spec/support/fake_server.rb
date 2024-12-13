RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /jsonplaceholder.typicode.com/).to_rack(FakeMoviesClient)
  end
end
