# 'sinatra'
require './app/services/recipe_service'
require './app/cache/cache_service'
require './app/sources/recipe_source'
require './app/cache/in_memory_cache'
require './app/sources/recipe_puppy_client'
require './app/cache/redis_cache'
require 'sinatra'
require 'logger'
#TODO tratar erros
# teste de controller

#UNDERLYING_CACHE = InMemoryCache.new
UNDERLYING_CACHE = RedisCache.new
LOGGER = Logger.new(STDOUT)

get '/search' do
  content_type 'application/json'
  recipe_service.search(params["q"]).to_json
rescue RecipeSource::QueryError => e
  status 400
  LOGGER.info("Client error")
  error_parsed(e.message)
rescue  RecipeSource::SourceError
  status 500
  error_parsed(e.message)
rescue Exception => e
  error_parsed(e.message)
  LOGGER.info("Server error")
end

#TODO como inicializar as coisas apenas uma vez no sinatra
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
  UNDERLYING_CACHE
end

def underlying_source
  @underlying_source ||= RecipePuppyClient
end

def error_parsed(message)
  {
    error_message: message
  }.to_json
end