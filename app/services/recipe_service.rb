require 'byebug'
class RecipeService

  LOGGER =  Logger.new(STDOUT)

  def initialize(cache, client)
    @cache = cache
    @client = client
  end

  def search(query, size = 20)
    result = @cache.get(query)
    LOGGER.debug("result = #{result}")
    if result
      LOGGER.info("Search for #{query} found in cache")
      return result
    end
    result = @client.search(query, size)
    LOGGER.info("Search for #{query} used the client and retrieved #{result.size} results of #{size} desired")
    @cache.put(query, result)
    LOGGER.info("Cache updated for #{query}")
    result
  end
end
