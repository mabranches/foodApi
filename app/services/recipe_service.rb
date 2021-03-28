require 'byebug'
class RecipeService
  def initialize(cache, client)
    @cache = cache
    @client = client
  end

  def search(query, size = 20)
    result = @cache.get(query)
    return result if result
    result = @client.search(query, size)
    @cache.put(query, result)
    result
  end
end
