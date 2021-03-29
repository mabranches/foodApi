class InMemoryCache
  MAX_SIZE = 100_000
  def initialize
    puts 'cache initialized'
    @cache = {}
  end

  def get(key)
    @cache[key]
  end

  def put(key, value)
    @cache.delete[@cache.first[0]] if @cache.size >= MAX_SIZE
    @cache[key] = value
  end
end
