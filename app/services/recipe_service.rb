require 'logger'
class RecipeService
  LOGGER = Logger.new($stdout)

  def initialize(cache, client)
    @cache = cache
    @client = client
  end

  def search(query, size = 20)
    from_cache(query) || from_source(query, size)
  end

  private

  def from_cache(query)
    result = @cache.get(query)
    LOGGER.debug("result = #{result}")
    LOGGER.info("Search for #{query} found in cache") if result
    result
  end

  def from_source(query, size)
    result = @client.search(query, size)
    LOGGER.info("Search for #{query} used the client and retrieved #{result.size} results of #{size} desired")
    @cache.put(query, result)
    LOGGER.info("Cache updated for #{query}")
    result
  end
end
