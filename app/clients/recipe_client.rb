class RecipeClient
  class QueryError < StandardError; end
  class SourceError < StandardError; end

  def initialize(underline_client)
    @underline_client = underline_client
  end

  def search(query, size)
    @underline_client.get(query, size)
  end
end
