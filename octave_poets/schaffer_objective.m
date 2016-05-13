function [total_objective_array] = schaffer_objective(parameter_array)

  BIG = 1e10;

  % Alias the species -
  x = parameter_array(1,1);

  % Calculate the objective function array -
  obj_array = BIG*ones(2,1);

  % f1 and f2 -
  obj_array(1,1) = (x^2);
  obj_array(2,1) = (x - 2)^2;

  % Constraints are implemented as a penaltly on obj value
  lambda_value = 100.0;

  % How much do we violate the constraints?
  penaltly_array = zeros(2,1);

  % return the obj_array -
  total_objective_array = obj_array+penaltly_array;
return;
