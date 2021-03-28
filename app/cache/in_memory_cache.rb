class InMemoryCache
  MAX_SIZE = 100000
  def initialize
    @cache = {}
  end

  def get(key)
    @cache[key]
  end

  def put(key, value)
    if @cache.size >= MAX_SIZE
      @cache.delete[@cache.first[0]]
    end
    @cache[key] = value
  end
end