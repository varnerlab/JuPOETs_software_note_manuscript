# some global parameters -
BIG = 1e10

# Evaluates the objective function values -
function objective_function(parameter_array)

  # Alias the species -
  x = parameter_array[1]

  # Calculate the objective function array -
  obj_array = BIG*ones(2,1)

  # f1 and f2 -
  obj_array[1] = (x^2)
  obj_array[2] = (x - 2)^2

  # Constraints are implemented as a penaltly on obj value
  lambda_value = 100.0

  # How much do we violate the constraints?
  penaltly_array = zeros(2)

  # return the obj_array -
  return obj_array+penaltly_array
end

# Generates new parameter array, given current array -
function neighbor_function(parameter_array)

  SIGMA = 0.05
  number_of_parameters = length(parameter_array)

  # calculate new parameters -
  new_parameter_array = parameter_array.*(1+SIGMA*randn(number_of_parameters))

  # Check the bound constraints -
  LOWER_BOUND = -10
  UPPER_BOUND = 10

  # return the corrected parameter arrays -
  return parameter_bounds_function(new_parameter_array,LOWER_BOUND,UPPER_BOUND)
end

function acceptance_probability_function(rank_array,temperature)

  return (exp(-rank_array[end]/temperature))

end

# Helper functions -
function parameter_bounds_function(parameter_array,lower_bound_array,upper_bound_array)

  # reflection_factor -
  epsilon = 0.01

  # iterate through and fix the parameters -
  new_parameter_array = copy(parameter_array)
  for (index,value) in enumerate(parameter_array)

    lower_bound = lower_bound_array[index]
    upper_bound = upper_bound_array[index]

    if (value<lower_bound)
      new_parameter_array[index] = lower_bound
    elseif (value>upper_bound)
      new_parameter_array[index] = upper_bound
    end
  end

  return new_parameter_array

end
