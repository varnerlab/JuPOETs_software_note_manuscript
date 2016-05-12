# Script to generate test data from the bihn and korn function
include("fonseca_fleming_lib.jl")

number_of_subdivisions = 10
number_of_states = 4
initial_state_array = zeros(number_of_states)
x_initial_array = linspace(-4,4,number_of_subdivisions)
iz = find(x_initial_array==0.0)
x_initial_array[iz] = randn(length(iz))


ec_array = zeros(2)
pc_array = zeros(number_of_states)
for index in collect(1:number_of_subdivisions)

  initial_state_array[1] = float(x_initial_array[index])
  initial_state_array[2] = float(x_initial_array[index])
  (EC,PC,RA) = estimate_ensemble(objective_function,neighbor_function,acceptance_probability_function,initial_state_array;rank_cutoff=4,maximum_number_of_iterations=12)

  ec_array = [ec_array EC]
  pc_array = [pc_array PC]

end

# rerank -
final_rank_array = rank_function(ec_array)
