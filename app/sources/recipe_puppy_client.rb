require 'json'
require 'logger'
class RecipePuppyClient
  BASE_URL = 'http://www.recipepuppy.com/api?'.freeze
  TIMEOUT_TIME = 2
  LOGGER = Logger.new($stdout)

  class << self
    def search(query, size)
      find_in_api(query, size)
    rescue RestClient::BadRequest => e
      raise RecipeSource::QueryError, e.message
    rescue RestClient::InternalServerError => e
      raise RecipeSource::SourceError, e.message
    rescue StandardError => e
      raise RecipeSource::SourceError, e.message
    end

    private

    def find_in_api(query, size)
      pages = size / 10

      result = request_api(pages, query)
      result.flat_map do |r|
        JSON.parse(r.body)['results']
      end
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
      result
    end

    def search_url(query, page)
      BASE_URL + "q=#{query}&p=#{page}"
    end
  end
end
