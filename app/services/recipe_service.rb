require 'byebug'
class RecipeService
  def initialize(cache, client)
    @cache = cache
    @client = client
  end

  def search(query)
    result = @cache.get(query, size = 20)
    return result if result
    result = @client.search(query, size)
    @cache.put(result)
    result
  end
end
