require 'json'
require 'logger'
class RecipePuppyClient

  BASE_URL = 'http://www.recipepuppy.com/api?'.freeze
  TIMEOUT_TIME = 2
  LOGGER =  Logger.new(STDOUT)

  class << self
    def search(query, size)
      find_in_api(query, size)
    end

    private
    def find_in_api(query, size)
      pages = size/10

      result = request_api(pages, query)
      result.collect do |r|
        JSON.parse(r.body)['results']
      end.flatten

    rescue RecipeSource::SourceError => e
      LOGGER.error("Source error: #{e}")
      raise RecipeSource::SourceError
    rescue RecipeSource::QueryError => e
      LOGGER.error("Query error: #{e}")
      raise RecipeSource::QueryError
    rescue Exception => e
      LOGGER.error( "Error requesting the API: #{e}")
      raise RecipeSource::SourceError
    end

    def request_api(pages, query)
      result = []
      threads = []
      pages.times.each do |i|
        threads << Thread.new do
          result[i] = RestClient::Request.execute(method: :get, url: search_url(query, i + 1), timeout: TIMEOUT_TIME)
        end
      end

      threads.each(&:join)

      result.each do |r|
        raise RecipeSource::SourceError if server_error?(r.code)
        raise RecipeSource::QueryError if client_error?(r.code)
      end
      result
    end

    def search_url(query, page)
      BASE_URL + "q=#{query}&p=#{page}"
    end

    def server_error?(code)
      code/500 == 1
    end

    def client_error?(code)
      code/400 == 1
    end
  end
end
