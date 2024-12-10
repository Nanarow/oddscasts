json.extract! article, :id, :title, :description, :cover, :created_at, :updated_at
json.url article_url(article, format: :json)
json.cover url_for(article.cover)
