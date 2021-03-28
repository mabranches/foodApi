class InMemoryCache
  MAX_SIZE = 100000
  def initialize
    puts "cache initialized"
    @cache = {}
  end

  def get(key)
    puts "cache=#{@cache}"
    @cache[key]
  end

  def put(key, value)
    if @cache.size >= MAX_SIZE
      @cache.delete[@cache.first[0]]
    end
    @cache[key] = value
  end
end