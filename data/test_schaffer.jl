# Script to generate test data from the bihn and korn function
include("schaffer_lib.jl")

function test_schaffer()

  number_of_subdivisions = 10
  initial_state_array = zeros(1)
  x_initial_array = linspace(-10,10,number_of_subdivisions)
  ec_array = zeros(2)
  pc_array = zeros(1)
  ra_array = zeros(1)
  for index in collect(1:number_of_subdivisions)

    initial_state_array[1] = float(x_initial_array[index])
    (EC,PC,RA) = estimate_ensemble(objective_function,neighbor_function,acceptance_probability_function,initial_state_array;rank_cutoff=4,maximum_number_of_iterations=10,show_trace=false)

    #@show size(RA)

    ec_array = [ec_array EC]
    pc_array = [pc_array PC]
    #ra_array = [ra_array RA]
  end

  return (ec_array,pc_array,ra_array)
end
