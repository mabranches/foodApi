require 'redis'
require 'json'

# TODO: configure redis to limit memory usage
class RedisCache
  def initialize
    @redis = Redis.new(host: 'redis', port: 6379, db: 'recipeCache')
  end

  def get(key)
    result = @redis.get(key)
    result.nil? ? result : JSON.parse(result, quirks_mode: true)
  end

  def put(key, value)
    @redis.set(key, value.to_json)
  end
end
