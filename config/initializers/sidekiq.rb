require 'sidekiq/web'

# settings
redis_url = Redis.current.client.id

# server
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: 'sidekiq' }
end

# client
Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: 'sidekiq' }
end