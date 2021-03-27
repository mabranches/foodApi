require 'rspec'
require './app/clients/recipe_puppy_client.rb'

describe RecipePuppyClient do

  subject { RecipePuppyClient }

  describe "#search" do

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
end
