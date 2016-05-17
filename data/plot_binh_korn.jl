using PyPlot
using POETs

# load the data -
ec_array = readdlm("./ec_array_binh_korn.dat")

# re-rank the solutions -
rank_array = rank_function(ec_array[:,2:end])


idx_rank_1 = find(rank_array.>=1.0)
plot(ec_array[1,idx_rank_1],ec_array[2,idx_rank_1],".",color="0.75")

# Plot rank 0 in black -
idx_rank_0 = find(rank_array.==0.0)
plot(ec_array[1,idx_rank_0],ec_array[2,idx_rank_0],"k.")
