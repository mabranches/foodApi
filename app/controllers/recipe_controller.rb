# 'sinatra'
require './app/services/recipe_service'
require './app/cache/cache_service'
require './app/sources/recipe_source'
require './app/cache/in_memory_cache'
require './app/sources/recipe_puppy_client'
require 'sinatra'
#TODO tratar erros
# teste de controller

before do
  content_type 'application/json'
end

get '/search' do
  recipe_service.search(params["q"]).to_json
end

private
def recipe_service
  @recipe_service ||= RecipeService.new(cache_service, recipe_source)
end

def cache_service
  @cache_service ||= CacheService.new(underlying_cache)
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