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


## Complete r6 Class

```r
# Add a binding for power rating
microwave_oven_factory <- R6Class(
  "MicrowaveOven",
  private = list(
    ..power_rating_watts = 800,
    ..power_level_watts = 800
  ),
  # Add active list containing an active binding
  active = list(
    power_level_watts = function(value) {
      if(missing(value)) {
        # Return the private value
        private$..power_level_watts
      } else {
        # Assert that value is a number
        assert_is_a_number(value)
        # Assert that value is in a closed range from 0 to power rating
        assert_all_are_in_closed_range(
          value, lower = 0, upper = private$..power_rating_watts
        )
        # Set the private power level to value
        private$..power_level_watts <- value
      }
    }
  )
)

# Make a microwave 
a_microwave_oven <- microwave_oven_factory$new()

# Get the power level
a_microwave_oven$power_level_watts

# Try to set the power level to "400"
a_microwave_oven$power_level_watts <- "400"

# Try to set the power level to 1600 watts
a_microwave_oven$power_level_watts <- 1600

# Set the power level to 400 watts
a_microwave_oven$power_level_watts <- 400
```


## Inheritance

```r
# Explore the microwave oven class
microwave_oven_factory

# Define a fancy microwave class inheriting from microwave oven
fancy_microwave_oven_factory <- R6Class(
    "FancyMicrowaveOven",
    inherit = microwave_oven_factory
)
# Explore microwave oven classes
microwave_oven_factory
fancy_microwave_oven_factory

# Instantiate both types of microwave
a_microwave_oven <- microwave_oven_factory$new()
a_fancy_microwave <- fancy_microwave_oven_factory$new()

# Get power rating for each microwave
microwave_power_rating <- a_microwave_oven$power_rating_watts
fancy_microwave_power_rating <-a_fancy_microwave$power_rating_watts

# Verify that these are the same
identical(microwave_power_rating, fancy_microwave_power_rating)

# Cook with each microwave
a_microwave_oven$cook(1)
a_fancy_microwave$cook(1)



## Extending the Cooking Capabilities

```r
# Explore microwave oven class
microwave_oven_factory

# Extend the class definition
fancy_microwave_oven_factory <- R6Class(
  "FancyMicrowaveOven",
  inherit = microwave_oven_factory,
  # Add a public list with a cook baked potato method
  public = list(
    cook_baked_potato = function(){
      self$cook(3)
    }
    
    
  )
)

# Instantiate a fancy microwave
a_fancy_microwave <- fancy_microwave_oven_factory$new()

# Call the cook_baked_potato() method
a_fancy_microwave$cook_baked_potato()
```

## Overriding the Cooking Capabilities
Child classes can also extend functionality by overriding methods. They do this by defining methods with the same name as that of the parent.

Child classes can access public methods from their parent class by prefixing the name with super$.


```r
# Explore microwave oven class
microwave_oven_factory

# Update the class definition
fancy_microwave_oven_factory <- R6Class(
  "FancyMicrowaveOven",
  inherit = microwave_oven_factory,
  # Add a public list with a cook method
  public = list(
    cook = function(time_seconds){
      super$cook(time_seconds)
      message("Enjoy your dinner!")
    }
    
    
    
  )
)

# Instantiate a fancy microwave
a_fancy_microwave <- fancy_microwave_oven_factory$new()

# Call the cook() method
a_fancy_microwave$cook(1)
```

## Multiple Levels of Inheritance

1. Exposing Parent Methods

```r
# Expose the parent functionality
fancy_microwave_oven_factory <- R6Class(
  "FancyMicrowaveOven",
  inherit = microwave_oven_factory,
  public = list(
    cook_baked_potato = function() {
      self$cook(3)
    },
    cook = function(time_seconds) {
      super$cook(time_seconds)
      message("Enjoy your dinner!")
    }
  ),
  # Add an active element with a super_ binding
  active = list(
    super_ = function() super
  )
)

# Instantiate a fancy microwave
a_fancy_microwave <- fancy_microwave_oven_factory$new()

# Call the super_ binding
a_fancy_microwave$super_
```

## Over-Overriding the Cooking Capabilities
Once intermediate classes have exposed their parent functionality with super_ active bindings, you can access methods across several generations of R6 class. The syntax is

parent_method <- super$method()
grand_parent_method <- super$super_$method()
great_grand_parent_method <- super$super_$super_$method()

```r
# Explore other microwaves
microwave_oven_factory
fancy_microwave_oven_factory

# Define a high-end microwave oven class
high_end_microwave_oven_factory <- R6Class(
  "HighEndMicrowaveOven",
  inherit = fancy_microwave_oven_factory,
  public = list(
    cook = function(time_seconds) {
      super$super_$cook(time_seconds)
      message(ascii_pizza_slice)
    }
  )
)

# Instantiate a high-end microwave oven
a_high_end_microwave <- high_end_microwave_oven_factory$new()

# Use it to cook for one second
a_high_end_microwave$cook(1)
```