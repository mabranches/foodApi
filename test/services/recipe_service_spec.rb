require 'rspec'
require './app/services/recipe_service.rb'
require './app/sources/recipe_source.rb'
require './test/test_helper'

describe RecipeService do
  describe "#search" do

    let(:client) { Object.new }
    let(:cache) { Object.new }
    subject{RecipeService.new(cache, client)}

    it 'Raises an exception on source error' do
      allow(client).to receive(:search).and_raise(RecipeSource::SourceError.new('error message'))
      allow(cache).to receive(:get).and_return(nil)
      allow(cache).to receive(:put)

      expect(cache).to receive(:get)
      expect(cache).not_to receive(:put)
      expect { subject.search("test") }.to raise_error(RecipeSource::SourceError)
    end

    context 'Query result is cached' do
      it 'Gets result from cache and do not call the client when search is cached' do
        allow(cache).to receive(:get).and_return(items_response_5_parsed)
        expect(client).not_to receive(:search)
        expect(cache).to receive(:get)
        expect(cache).not_to receive(:put)
        expect(subject.search("test")).to eq(items_response_5_parsed)
      end
    end

    context 'Query result is not cached' do
      it 'Gets result from client and update cache when search is not in cache' do
        allow(cache).to receive(:get).and_return(nil)
        allow(client).to receive(:search).and_return(items_response_5_parsed)
        expect(cache).to receive(:get)
        expect(client).to receive(:search)
        expect(cache).to receive(:put).with('test', items_response_5_parsed)
        expect(subject.search("test")).to eq(items_response_5_parsed)
      end

      it 'Returns empty array if client returns no items' do
        allow(cache).to receive(:get).and_return(nil)
        allow(cache).to receive(:put).with('test', [])
        allow(client).to receive(:search).and_return([])
        expect(subject.search('test')).to eq([])
      end
    end
  end
end
