require 'rspec'
require './app/services/recipe_service.rb'
require './app/clients/recipe_client.rb'

describe RecipeService do


  describe "#search" do

    let(:client) { Object.new }
    let(:cache) { Object.new }
    subject{RecipeService.new(cache, client)}

    it 'Raises an exception on source error' do

      allow(client).to receive(:search).and_raise(RecipeClient::SourceError.new)
      allow(cache).to receive(:get).and_return(nil)
      allow(cache).to receive(:put)

      expect(cache).to receive(:get)
      expect(cache).not_to receive(:put)
      expect { subject.search("test") }.to raise_error(RecipeClient::SourceError)
    end

    it 'Gets result from cache and do not call the client when search is cached' do

      allow(cache).to receive(:get).and_return(items_response_5)
      expect(client).not_to receive(:search)
      expect(cache).to receive(:get)
      expect(cache).not_to receive(:put)
      expect(subject.search("test")).to eq(items_response_5)
    end

    it 'Gets result from client and update cache when search is not in cache' do
    end

    it 'Returns only 3 results when client returns 3 but query was 20' do
    end

    #it 'Returns 10 items if only second page is empty' do
    #end

    #it 'Returns 20 items if first and second page have 10 results' do
    #end

    it 'Returns empty array if client returns no items' do
    end

   # it 'Returns empty result on client timeout' do
    #end
  end

  def items_response_10

    [
      {
        "title": "Onion Bagels Recipe",
        "href": "http://www.grouprecipes.com/5615/onion-bagels.html",
        "ingredients": "butter, onions, water, bread flour, sugar, salt, sugar, water, yeast, eggs",
        "thumbnail": "http://img.recipepuppy.com/224906.jpg"
      },
      {
        "title": "Chicken With Pistachio Sauce and Kumara Mash",
        "href": "http://www.recipezaar.com/Chicken-With-Pistachio-Sauce-and-Kumara-Mash-94707",
        "ingredients": "butter, chicken, cream, white wine, black pepper, green beans, lemon thyme, milk, olive oil, pistachios, salt",
        "thumbnail": ""
      },
      {
        "title": "Alains Sweet And Spicy Asian Drumsticks Recipe",
        "href": "http://www.grouprecipes.com/25169/alains-sweet-and-spicy-asian-drumsticks.html",
        "ingredients": "black pepper, cayenne, chicken drumstick, cilantro, oregano, thyme, cajun seasoning, garlic, garlic powder, ginger, green onion, rice wine, onion powder, orange juice, orange zest, paprika, pineapple juice, red pepper flakes, salt, salt, vegetable oil, soy sauce, sugar, sesame seeds",
        "thumbnail": "http://img.recipepuppy.com/307494.jpg"
      },
      {
        "title": "Crispy Oven Fried Mexican Chicken",
        "href": "http://www.recipezaar.com/Crispy-Oven-Fried-Mexican-Chicken-301010",
        "ingredients": "cheddar cheese, chili powder, garlic powder, cumin, hot sauce, oregano, paprika, black pepper, salt, juice",
        "thumbnail": ""
      },
      {
        "title": "Patricias Cherry Butter Recipe",
        "href": "http://www.grouprecipes.com/11060/patricias-cherry-butter.html",
        "ingredients": "almond extract, liquid pectin, butter, cinnamon, lemon juice, sugar, tart cherries",
        "thumbnail": "http://img.recipepuppy.com/342940.jpg"
      },
      {
        "title": "Patatoullie Recipe",
        "href": "http://www.grouprecipes.com/25947/patatoullie.html",
        "ingredients": "celery, cheddar cheese, cheese, potato, savory, shallot",
        "thumbnail": ""
      },
      {
        "title": "Hor Mok Steamed Mixed Seafood Cake Recipe",
        "href": "http://www.grouprecipes.com/22618/hor-mok-steamed-mixed-seafood-cake.html",
        "ingredients": "flour, coconut milk, fish, fish sauce, kaffir lime leaves, chili, curry paste, basil, salad greens, coconut",
        "thumbnail": ""
      },
      {
        "title": "Strawberry Sorbet Recipe",
        "href": "http://www.grouprecipes.com/4179/strawberry-sorbet.html",
        "ingredients": "sugar, strawberries, lime juice, water",
        "thumbnail": "http://img.recipepuppy.com/396220.jpg"
      }
    ]
  end

  def items_response_5
    [
      {
      "title": "Onion Bagels Recipe",
      "href": "http://www.grouprecipes.com/5615/onion-bagels.html",
      "ingredients": "butter, onions, water, bread flour, sugar, salt, sugar, water, yeast, eggs",
      "thumbnail": "http://img.recipepuppy.com/224906.jpg"
    },
    {
      "title": "Chicken With Pistachio Sauce and Kumara Mash",
      "href": "http://www.recipezaar.com/Chicken-With-Pistachio-Sauce-and-Kumara-Mash-94707",
      "ingredients": "butter, chicken, cream, white wine, black pepper, green beans, lemon thyme, milk, olive oil, pistachios, salt",
      "thumbnail": ""
    },
    {
      "title": "Alains Sweet And Spicy Asian Drumsticks Recipe",
      "href": "http://www.grouprecipes.com/25169/alains-sweet-and-spicy-asian-drumsticks.html",
      "ingredients": "black pepper, cayenne, chicken drumstick, cilantro, oregano, thyme, cajun seasoning, garlic, garlic powder, ginger, green onion, rice wine, onion powder, orange juice, orange zest, paprika, pineapple juice, red pepper flakes, salt, salt, vegetable oil, soy sauce, sugar, sesame seeds",
      "thumbnail": "http://img.recipepuppy.com/307494.jpg"
    }
    ]
  end

end
