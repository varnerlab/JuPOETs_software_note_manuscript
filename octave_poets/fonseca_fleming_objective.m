function [obj_array] = fonseca_fleming_objective(parameter_array)


  BIG = 1e10;

  # Alias the species -
  number_of_parameters = length(parameter_array);

  # Calculate the objective function array -
  obj_array = BIG*ones(2,1);

  # calculate the objectibe array -
  # calculate the sums
  sum_1 = 0.0;
  sum_2 = 0.0;
  for index = 1:number_of_parameters

    sum_1 = sum_1 + (parameter_array(index) - 1/sqrt(number_of_parameters))^2;
    sum_2 = sum_2 + (parameter_array(index) + 1/sqrt(number_of_parameters))^2;
  end

  # objectives -
  obj_array(1,1) = 1 - exp(-1*sum_1);
  obj_array(2,1) = 1 - exp(-1*sum_2);

return
