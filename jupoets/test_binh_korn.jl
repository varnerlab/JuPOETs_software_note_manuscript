# Script to generate test data from the bihn and korn function
include("binh_korn_lib.jl")

function test_binh_korn()

  number_of_subdivisions = 10
  initial_state_array = zeros(2)
  x_initial_array = linspace(0.01,5,number_of_subdivisions)
  y_initial_array = linspace(0.01,3,number_of_subdivisions)
  ec_array = zeros(2)
  pc_array = zeros(2)
  for index in collect(1:number_of_subdivisions)

    initial_state_array[1] = float(x_initial_array[index])
    initial_state_array[2] = float(y_initial_array[index])
    (EC,PC,RA) = estimate_ensemble(objective_function,neighbor_function,acceptance_probability_function,cooling_function,initial_state_array;rank_cutoff=4,maximum_number_of_iterations=20,show_trace=false)

    #@show size(RA)

    ec_array = [ec_array EC]
    pc_array = [pc_array PC]
  end

  return (ec_array,pc_array)
end
