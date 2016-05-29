# Script to extract parameter solutions from the ensemble that fit individual experiments -

include("SolveBalances.jl")
using PyPlot
using PyCall
@pyimport numpy as np

# What experiment do we want to see?
experiment_index = 3
MEASURED_ARRAY = readdlm("./data/MEASUREMENT_SET_3.dat")

# Load the ensemble files from disk -
pc_array_full = readdlm("./data/pc_array.dat")
ec_array_full = readdlm("./data/ec_array.dat")
rank_array = readdlm("./data/rank_array.dat")

# Select the desired rank -
idx_rank = find(rank_array .<= 1.0)

# Remove solutions that are above the rank threshold -
pc_array = pc_array_full[:,idx_rank]
ec_array = ec_array_full[:,idx_rank]

# Sort the remaining solutions for experiment_index from lowest to highest error -
idx_sort = sortperm(vec(ec_array[experiment_index,:]))


# Setup time scale -
tStart = 0.0;
tStop = 100.0;
tStep = 0.1;
number_of_timesteps = 400
time_experimental = linspace(tStart,tStop,number_of_timesteps)

# initialize data array -
data_array = zeros(length(time_experimental),1)

# Run the simulation for this rank -
number_of_samples_max = floor(0.25*length(idx_sort))
number_of_samples = 1
error_index_value = 1
while (number_of_samples<number_of_samples_max)

  # Grab the parameter set from the cache -
  parameter_array = pc_array[:,idx_sort[error_index_value]]

  # Run the model -
  (t,x) = SolveBalances(tStart,tStop,tStep,parameter_array)

  # Need to interpolate the simulation onto the experimental time scale -
  AI = np.interp(time_experimental[:],t,x[:,7])
  BI = np.interp(time_experimental[:],t,x[:,8])
  CI = np.interp(time_experimental[:],t,x[:,9])
  XI = np.interp(time_experimental[:],t,x[:,10])

  # grab -
  data_array = [data_array XI]

  # update the sample count -
  number_of_samples = number_of_samples + 1

  # Update the index for the next solution -
  error_index_value = error_index_value + 1
end

# calculate mean, and std
mean_value = mean(data_array,2)
std_value = std(data_array,2)
SF = (2.58/sqrt(number_of_samples))

UB = mean_value + (SF)*std_value
LB = mean_value - (SF)*std_value
idx_z = find(LB.<0)
LB[idx_z] = 0.0

# Make the plot of the simulation and data -
skip_index = 1:60:length(MEASURED_ARRAY[:,1])
plot(MEASURED_ARRAY[skip_index,1],MEASURED_ARRAY[skip_index,5],"ko")
#fill_between(vec(time_experimental),vec(LB),vec(UB),color="gray",lw=2)

# Make best fit plot -
# Grab the parameter set from the cache -
parameter_array = pc_array[:,idx_sort[1]]

# Run the model -
(t,x) = SolveBalances(tStart,tStop,tStep,parameter_array)

# Need to interpolate the simulation onto the experimental time scale -
AI = np.interp(time_experimental[:],t,x[:,7])
BI = np.interp(time_experimental[:],t,x[:,8])
CI = np.interp(time_experimental[:],t,x[:,9])
XI = np.interp(time_experimental[:],t,x[:,10])

BFUB = XI+std_value
BFLB = XI-std_value
idx_z = find(BFLB.<0)
BFLB[idx_z] = 0.0
plot(vec(time_experimental),XI,"k")
fill_between(vec(time_experimental),vec(BFLB),vec(BFUB),color=[0.7,0.7,0.7],lw=2)
