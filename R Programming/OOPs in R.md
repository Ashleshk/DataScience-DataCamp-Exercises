# R6 
The third argument to R6Class() is called public and holds the user-facing functionality for the object. This argument should be a list, with names for each of its elements.

The public element of an R6 class contains the functionality available to the user. Usually it will only contain functions.


```r
# Add a cook method to the factory definition
microwave_oven_factory <- R6Class(
  "MicrowaveOven",
  private = list(
    power_rating_watts = 800
  ),
  public = list(
    cook = function(time_seconds) {
      Sys.sleep(time_seconds)
      print("Your food is cooked!")
    }
  )
)

# Create microwave oven object
a_microwave_oven <- microwave_oven_factory$new()

# Call cook method for 1 second
a_microwave_oven$cook(1)
```

## # Add a close_door() method

```r

microwave_oven_factory <- R6Class(
  "MicrowaveOven",
  private = list(
    power_rating_watts = 800,
    door_is_open = FALSE
  ),
  public = list(
    cook = function(time_seconds) {
      Sys.sleep(time_seconds)
      print("Your food is cooked!")
    },
    open_door = function() {
      private$door_is_open <- TRUE
    },
    close_door = function(){
      private$door_is_open = FALSE
    }
    
    
  )
)
```

## Intializing 

```r
# Add an initialize method
microwave_oven_factory <- R6Class(
  "MicrowaveOven",
  private = list(
    power_rating_watts = 800,
    door_is_open = FALSE
  ),
  public = list(
    cook = function(time_seconds) {
      Sys.sleep(time_seconds)
      print("Your food is cooked!")
    },
    open_door = function() {
      private$door_is_open <- TRUE
    },
    close_door = function() {
      private$door_is_open <- FALSE
    },
    # Add initialize() method here
    initialize = function(power_rating_watts, door_is_open) {
      if(!missing(power_rating_watts)) {
        private$power_rating_watts <- power_rating_watts
      }
      if(!missing(door_is_open)) {
        private$door_is_open <- door_is_open
      }
      
      
    }
  )
)

# Make a microwave
a_microwave_oven <- microwave_oven_factory$new(power_rating_watts = 650,door_is_open =TRUE)

```

## Setting And Getting Active Binding 

```r
# Add a binding for power rating
microwave_oven_factory <- R6Class(
  "MicrowaveOven",
  private = list(
    ..power_rating_watts = 800
  ),
  active = list(
    # Add the binding here
    power_rating_watts = function() {
      private$..power_rating_watts
    }
  )
)

# Make a microwave 
a_microwave_oven <- microwave_oven_factory$new()

# Get the power rating
a_microwave_oven$power_rating_watts
```