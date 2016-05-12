function [new_parameter_array] = neighbor(parameter_array)

  SIGMA = 0.05;
  number_of_parameters = length(parameter_array);

  % calculate new parameters -
  new_parameter_array = parameter_array.*(1+SIGMA*randn(number_of_parameters));

  % Check the bound constraints -
  LOWER_BOUND = [0,0];
  UPPER_BOUND = [5,3];

  % return the corrected parameter arrays -
  new_parameter_array =  parameter_bounds_function(new_parameter_array,LOWER_BOUND,UPPER_BOUND);
return

function [new_parameter_array] = parameter_bounds_function(parameter_array,lower_bound_array,upper_bound_array)

  % reflection_factor -
  epsilon = 0.01;

  % iterate through and fix the parameters -
  new_parameter_array = parameter_array;
  number_of_parameters = length(new_parameter_array);
  for index = 1:number_of_parameters

    value = parameter_array(index,1);

    lower_bound = lower_bound_array(index);
    upper_bound = upper_bound_array(index);

    if (value<lower_bound)
      new_parameter_array(index,1) = lower_bound + epsilon*upper_bound;
    elseif (value>upper_bound)
      new_parameter_array(index,1) = upper_bound - epsilon*lower_bound;
    end
  end

return;
