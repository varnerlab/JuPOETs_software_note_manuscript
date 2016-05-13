function [rank_archive,error_cache,parameter_cache,elapsed_time] = schaffer_test()

  # start -
  id = tic();

  % Ok, we need to split the domain into a number of subdivisions -
  number_of_subdivisions = 10;
  x_initial_array = linspace(-10,10,number_of_subdivisions);

  % Setup the function pointers -
  pObjectiveFunction = @schaffer_objective;
  pNeighborFunction = @schaffer_neighbor;
  pCoolingFunction = @cooling;
  pAcceptanceFunction = @acceptance;

  % setup interations et al
  maximum_number_of_iterations = 10;
  rank_cutoff = 5;
  show_trace = false;

  rank_archive = [];
  error_cache = [];
  parameter_cache = [];

  % main run loop -
  for domain_index = 1:number_of_subdivisions

    %domain_index

    % setup inital guess -
    initial_state = zeros(1,1);
    initial_state(1,1) = x_initial_array(domain_index);

    % call POETs
    [RA,EC,PC] = POETs(pObjectiveFunction,pNeighborFunction,pAcceptanceFunction,initial_state,maximum_number_of_iterations,rank_cutoff,show_trace);

    % cache -
    rank_archive = [rank_archive RA];
    error_cache = [error_cache EC];
    parameter_cache = [parameter_cache PC];

  end

  elapsed_time = toc(id);

return
