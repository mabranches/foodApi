# 'sinatra'
require './app/cache/in_memory_cache'
#TODO tratar erros
# teste de controller

get '/search' do |query|
  recipe_service.search(query)
end

private
def recipe_service
  @recipe_service ||= RecipeService.new(cache_service, recipe_source)
end

def cache_service
  @cache_service ||= CacheService.ne(underlying_cache)
end

def recipe_source
  @recipe_source ||= RecipeSource.new(underlying_source)
end

def underlying_cache
  @underlying_cache ||= InMemoryCache.new
end

def underlying_source
  @underlying_source ||= RecipePuppyClient
end