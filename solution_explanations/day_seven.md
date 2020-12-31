# Handy Haversacks 
```mix day_seven``` will execute the solutions. 

## Part 1
Given a list of bags containing other bags, determine how many bag colors can contain a shiny golden bag.

### Solution
This solution uses the :digraph construct from Erlang to find the number of ancestor nodes. 
Once the data is parsed and placed into the digraph ```:digraph_utils.reaching()``` will return the number of ancestor nodes (plus 1).
* Create Graph - Erlang digraph
* use :digraph_utils.reachable() to get number of ancestors.
