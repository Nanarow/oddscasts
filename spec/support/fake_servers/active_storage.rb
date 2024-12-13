require 'sinatra/base'
require 'json'

class FakeActiveStorage < Sinatra::Base
  before do
    headers 'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => [ 'OPTIONS', 'GET', 'POST', 'PUT', 'DELETE' ],
            'Access-Control-Allow-Headers' => [ 'Content-Type', 'Authorization', 'Accept' ]
  end

  # Handle preflight OPTIONS requests
  options '*' do
    200
  end

  # Direct upload endpoint
  post '/rails/active_storage/direct_uploads' do
    content_type :json
    request_data = JSON.parse(request.body.read)

    {
      id: SecureRandom.uuid,
      key: "#{SecureRandom.hex}/#{request_data['filename']}",
      filename: request_data['filename'],
      content_type: request_data['content_type'],
      metadata: {},
      byte_size: request_data['byte_size'],
      checksum: request_data['checksum'],
      created_at: Time.now.iso8601,
      signed_id: SecureRandom.uuid,
      direct_upload: {
        url: "#{request.base_url}/rails/active_storage/disk/#{SecureRandom.hex}",
        headers: {
          'Content-Type' => request_data['content_type']
        }
      }
    }.to_json
  end

  # Blob storage endpoint
  put '/rails/active_storage/disk/:id' do
    content_type :json
    status 200
    { status: 'ok' }.to_json
  end

  # Serving blobs
  get '/rails/active_storage/blobs/redirect/:signed_id/*filename' do
    content_type :json
    status 302
    headers 'Location' => "#{request.base_url}/#{params[:filename]}"
    { status: 'redirect' }.to_json
  end
end
