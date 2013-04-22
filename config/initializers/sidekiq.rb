require 'sidekiq/web'

# settings
redis = Redis.new(host: ActiveSupport::JSON.decode(`sudo cat /etc/chef/dna.json`)['db_host'])
redis_url = redis.client.id

# server
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: 'sidekiq' }
end

# client
Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: 'sidekiq' }
end