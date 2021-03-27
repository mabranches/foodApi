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
        raise RecipeClient::SourceError if is_server_error(r.code)
        raise RecipeClient::QueryError if is_client_error(r.code)
      end
      result
    end

    def search_url(query, page)
      BASE_URL + "q=#{query}&p=#{page}"
    end

    def is_server_error(code)
      code/500 == 1
    end

    def is_client_error(code)
      code/400 == 1
    end
  end
end
