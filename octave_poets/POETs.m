function [pareto_rank_array,error_cache,parameter_cache] = POETs(objective_function,neighbor_function,acceptance_probability_function,initial_state,maximum_number_of_iterations,rank_cutoff,show_trace)

  % internal parameters -
  temperature = 1.0;
  temperature_min = temperature/10000;
  alpha = 0.90;

  % Grab the initial parameters -
  parameter_array_best = initial_state;

  % initialize error cache -
  error_cache = objective_function(parameter_array_best);

  % initialize parameter_cache -
  parameter_cache = parameter_array_best;

  % initialize the Pareto rank array from the error_cache -
  pareto_rank_array = rank_function(error_cache);

  % how many objectives do we have?
  number_of_objectives = length(error_cache);

  %keyboard

  % main loop -
  while (temperature>temperature_min)

    should_loop_continue = true;
    iteration_index = 1;
    while (should_loop_continue)

      % generate a new solution -
      test_parameter_array = neighbor_function(parameter_array_best);

      %keyboard

      % evaluate the new solution -
      test_error = objective_function(test_parameter_array);

      % Add the test error to the error cache -
      error_cache = [error_cache test_error];

      % Add parameters to parameter cache -
      parameter_cache = [parameter_cache test_parameter_array];

      % compute the Pareto rank for the error_cache -
      pareto_rank_array = rank_function(error_cache);

      % do we accept the new solution?
      acceptance_probability = acceptance_probability_function(pareto_rank_array,temperature);
      if (acceptance_probability>rand())

        % Select the rank -
        archive_select_index = find(pareto_rank_array<rank_cutoff);

        % update the caches -
        error_cache = error_cache(:,archive_select_index);
        parameter_cache = parameter_cache(:,archive_select_index);

        % update the parameters -
        parameter_array_best = test_parameter_array;

        if (show_trace == true)
          msg = ['iteration_index = ',num2str(iteration_index),' temperature = ',num2str(temperature)];
          disp(msg)
        end
      end

      %msg = ['iteration_index = ',num2str(iteration_index),' temperature = ',num2str(temperature)]
      %disp(msg)

      % check - should we go around again?
      if (iteration_index>maximum_number_of_iterations)
        should_loop_continue = false;
      end;

      % update the loop index -
      iteration_index = iteration_index + 1;
    end % end: inner while-loop (iterations)

    % update the temperature -
    temperature = alpha*temperature;

  end % end: outer while-loop (temperature)

% return the caches -
return;

% Pareto ranking function -
function [Rank] = rank_function(error_cache)

  NObj = size(error_cache,1); % Number of objective functions
  NPop = size(error_cache,2); % Number of population

  for Indv = 1:NPop
	  Indv_dom = 1:NPop; % Initial index for dominated individuls
	  for i = 1:NObj
		    Idom = find(error_cache(i,Indv_dom)<=error_cache(i,Indv)); % find the index for dominated individuals
		    Indv_dom = Indv_dom(Idom); % remove non-dominated individuals and update the donimating index
	  endfor

    Rank(Indv) = length(Indv_dom)-1; % Count dominated indivisuals. if Indv is pareto-optimal, Rang(Indv) = 0.
  endfor
return
