json.extract! video, :id, :title, :description, :url, :cover, :created_at, :updated_at
json.url video_url(video, format: :json)
json.cover url_for(video.cover)
