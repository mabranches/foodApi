require 'redis'
class RedisCache

  def initialize
    @redis = Redis.new(host: 'redis', port: 6379, db: 'recipeCache')
  end

  def get(key)
    @redis.get(key)
  end

  def put(key, value)
    @redis.set(key, value)
  end
end
