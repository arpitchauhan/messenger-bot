$redis = Redis.new(url: ENV[ENV['REDIS_PROVIDER'] || 'REDIS_URL'] || 'redis://localhost:6379')
