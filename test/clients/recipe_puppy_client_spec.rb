require 'rspec'
require './app/sources/recipe_puppy_client.rb'
require './test/test_helper'
require 'rest-client'

describe RecipePuppyClient do

  subject { RecipePuppyClient }

  describe "#search" do

    it 'Returns only 5 results when client returns only 5 in first page' do
      mock_request("http://www.recipepuppy.com/api?q=test&p=1", items_response_5)
      mock_request("http://www.recipepuppy.com/api?q=test&p=2", items_response_empty)
      expect(subject.search('test',20)).to match_array(items_response_5_parsed)
    end

    it 'Returns 10 items if only second page is empty' do
    end

    it 'Returns 20 items if first and second page have 10 results' do
    end

    it 'Returns 20 items if first and second page have 10 results' do
    end

    it 'Returns empty array if client returns no items' do
    end

    it 'Returns empty result on client timeout' do
    end
  end
end

def mock_request(url, result)
  allow(RestClient::Request)
    .to receive(:execute)
          .with(
            method: :get,
            url: url,
            timeout: RecipePuppyClient::TIMEOUT_TIME
          ).and_return(result)
end

def items_response_10
  response = Object.new
  allow(response).to receive(:code).and_return(200)
  allow(response).to receive(:body).and_return("{\"title\":\"Recipe Puppy\",\"version\":0.1,\"href\":\"http:\\/\\/www.recipepuppy.com\\/\",\"results\":[{\"title\":\"Grilled Shrimp Recipe\",\"href\":\"http:\\/\\/www.grouprecipes.com\\/76252\\/grilled-shrimp.html\",\"ingredients\":\"butter, cloves, shrimp, lemon, white wine, lemon juice, almonds\",\"thumbnail\":\"http:\\/\\/img.recipepuppy.com\\/327312.jpg\"},{\"title\":\"Creamy Curried Shrimp with Grilled Pineapple\",\"href\":\"http:\\/\\/allrecipes.com\\/Recipe\\/Creamy-Curried-Shrimp-with-Grilled-Pineapple\\/Detail.aspx\",\"ingredients\":\"butter, flour, curry powder, milk, pineapple, salt, shrimp\",\"thumbnail\":\"\"},{\"title\":\"48 Hour Marinated Shrimp\",\"href\":\"http:\\/\\/www.recipezaar.com\\/48-Hour-Marinated-Shrimp-202178\",\"ingredients\":\"dijon mustard, basil, lemon juice, garlic, hot sauce, shrimp, lemon zest, red onions, red wine vinegar, salt, sugar, vegetable oil, water, worcestershire sauce, yellow bell pepper\",\"thumbnail\":\"\"},{\"title\":\"Black Shrimp\",\"href\":\"http:\\/\\/www.recipezaar.com\\/Black-Shrimp-51360\",\"ingredients\":\"butter, cajun seasoning, shrimp\",\"thumbnail\":\"\"},{\"title\":\"Champagne Grape and Shrimp Salad Sandwiches\",\"href\":\"http:\\/\\/www.recipezaar.com\\/Chagne-Grape-and-Shrimp-Salad-Sandwiches-48057\",\"ingredients\":\"shrimp, champagne, chives, olive oil, lemon, mayonnaise, sandwich rolls\",\"thumbnail\":\"http:\\/\\/img.recipepuppy.com\\/286421.jpg\"},{\"title\":\"Confetti Shrimp\",\"href\":\"http:\\/\\/www.recipezaar.com\\/Confetti-Shrimp-130313\",\"ingredients\":\"chives, ginger, garlic, lemon juice, lime juice, olive oil, red pepper, chili oil, salt, shrimp\",\"thumbnail\":\"http:\\/\\/img.recipepuppy.com\\/321416.jpg\"},{\"title\":\"Deep-Fried Coconut Shrimp With Dipping Sauce\",\"href\":\"http:\\/\\/www.recipezaar.com\\/Deep-Fried-Coconut-Shrimp-With-Dipping-Sauce-273422\",\"ingredients\":\"flour, flour, baking powder, beer, eggs, shrimp, coconut, vegetable oil\",\"thumbnail\":\"http:\\/\\/img.recipepuppy.com\\/358506.jpg\"},{\"title\":\"Garlic and Herb Shrimp\",\"href\":\"http:\\/\\/www.recipezaar.com\\/garlic-and-herb-shrimp-382083\",\"ingredients\":\"butter, parsley, garlic, lemon pepper, lemon, malt vinegar, old bay seasoning, black pepper\",\"thumbnail\":\"\"},{\"title\":\"Arlene's Shrimp Dip\",\"href\":\"http:\\/\\/allrecipes.com\\/Recipe\\/Arlenes-Shrimp-Dip\\/Detail.aspx\",\"ingredients\":\"salad dressing, curry powder, onions, paprika\",\"thumbnail\":\"\"},{\"title\":\"Ann's Shrimp Etoufee\",\"href\":\"http:\\/\\/allrecipes.com\\/Recipe\\/Anns-Shrimp-Etoufee\\/Detail.aspx\",\"ingredients\":\"black pepper, butter, celery, flour, garlic, paprika, red pepper, salt, shrimp, white onion\",\"thumbnail\":\"http:\\/\\/img.recipepuppy.com\\/29873.jpg\"}]}")
  response
end

def items_response_5
  response = Object.new
  allow(response).to receive(:code).and_return(200)
  allow(response).to receive(:body).and_return("{\"title\":\"Recipe Puppy\",\"version\":0.1,\"href\":\"http://www.recipepuppy.com/\",\"results\":[{\"title\":\"Beer Batter Shrimp\",\"href\":\"http://www.recipezaar.com/Beer-Batter-Shrimp-78333\",\"ingredients\":\"beer, vegetable oil, paprika, flour, salt, shrimp\",\"thumbnail\":\"\"},{\"title\":\"Boiled Shrimp\",\"href\":\"http://www.recipezaar.com/Boiled-Shrimp-99906\",\"ingredients\":\"beer, celery seed, old bay seasoning, red pepper flakes, shrimp, water, white vinegar\",\"thumbnail\":\"\"},{\"title\":\"Outback Steakhouse Grilled Shrimp On The Barbie Recipe\",\"href\":\"http://www.grouprecipes.com/22624/outback-steakhouse-grilled-shrimp-on-the-barbie.html\",\"ingredients\":\"allspice, black pepper, black pepper, butter, cayenne, celery, chili powder, garlic powder, green pepper, lemon juice, mayonnaise, milk, onion powder, paprika, sauce, salt, sauerkraut, shrimp, seasoning, mustard powder, sugar, white vinegar\",\"thumbnail\":\"http://img.recipepuppy.com/210654.jpg\"},{\"title\":\"Garlic Shrimp Pasta Recipe\",\"href\":\"http://www.grouprecipes.com/27449/garlic-shrimp-pasta.html\",\"ingredients\":\"butter, garlic, olive oil, parsley, red pepper flakes, black pepper, shrimp, linguine, white wine\",\"thumbnail\":\"http://img.recipepuppy.com/335312.jpg\"},{\"title\":\"Garlic Shrimp Recipe\",\"href\":\"http://www.grouprecipes.com/47507/garlic-shrimp.html\",\"ingredients\":\"olive oil, sea salt, garlic, shrimp, red pepper flakes, parsley, butter, lemon juice, white wine\",\"thumbnail\":\"http://img.recipepuppy.com/339593.jpg\"}]}")
  response
end

def items_response_empty
  response = Object.new
  allow(response).to receive(:code).and_return(200)
  allow(response).to receive(:body).and_return("{\"title\":\"Recipe Puppy\",\"version\":0.1,\"href\":\"http:\\/\\/www.recipepuppy.com\\/\",\"results\":[]}")
  response
end