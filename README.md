#Recipes API 

  This API uses the http://www.recipepuppy.com/about/api/ as Data Source.
  
  I opted by using Sinatra over Rails since is a very lightweight framework and we 
  wouldn't need many of rails functionalities like ActiveRecord.

  I use redis as cache and illustrate flexibility by also allowing a memory cache.

##Preparation 
To run this project you need docker-compose. You can see intalation 
instructions here https://docs.docker.com/compose/install/.
    Then you just need to build with
```shell
docker-compose build
```

##Run
 You can then run with
```shell
docker-compose up
```
##Test
To run the tests we have provided a script. Just execute with
```shell
./run_tests.sh
```

##Assumptions
Though the **recipe puppy** API provide more filters we do not support it in this API and let
  as future improvements
We provide a cache to be closer to real cenario such as we would try to minimize latency and external requests.

In a real case scenarios we would take care of some more in depth configurations 
   - API gateway configuration to be before this server and take care of things like rate limit
   - Limit redis memory usage and use a external cluster