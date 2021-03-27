class RecipePuppyClient

  BASE_URL = 'http://www.recipepuppy.com/api?'.freeze
  class << self
    def search(query, size)
      find_in_api(q, size)
    end

    private
    def find_in_api(q, size)
      threads = []
      result = []
      pages = size/10
      pages.times.each do |i|
        threads << Thread.new do |t|
          result[i] = RestClient.get(search_url(query, page))
        end
      end
      threads.each(&:join)
      result.each do |r|
        raise RecipeClient::SourceError if server_error?(r.code)
        raise RecipeClient::QueryError if client_error?(r.code)
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
