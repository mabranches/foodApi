class CacheService
  def initialize(underlying_cache)
    @cache = underlying_cache
  end

  def get(key)
    @cache.get(key)
  end

  def put(key, value)
    @cache.put(key, value)
  end
end
