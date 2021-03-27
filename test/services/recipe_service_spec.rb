require 'rspec'
require './app/services/recipe_service.rb'
require './app/clients/recipe_client.rb'

describe RecipeService do

  subject { RecipeService.new(cache, client) }

  describe "#search" do

    let (:client) do
      client_object = Object.new
      allow(client_object).to receive(:search).and_raise(RecipeClient::SourceError.new)
      client_object
    end

    let (:cache) do
      cache_object = Object.new
      allow(cache_object).to receive(:get).and_return(nil)
      allow(cache_object).to receive(:put)
      cache_object
    end

    it 'Raises an exception on source error' do
      expect { subject.search("test") }.to raise_error(RecipeClient::SourceError)
    end

    it 'Gets result from cache and do not call the client when search is cached' do
    end

    it 'Gets result from client and update cache when search is not in cache' do
    end

    it 'Returns only 5 results when client returns only 5 in first page' do
    end

    it 'Returns 10 itens if only second page is empty' do
    end

    it 'Returns 20 itens if first and second page have 10 results' do
    end

    it 'Returns empty array if client returns no items' do
    end

    it 'Returns empty result on client timeout' do
    end
  end

  def mock_cache
    object = Object.new
    allow(object).to receive(:search).and_return([])
  end

  def mock_client
    object = Object.new
    allow(object).to receive(:search).and_return([])
  end
end
