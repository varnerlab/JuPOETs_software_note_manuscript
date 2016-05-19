using POETs

# Script to write the model ensemble to disk -
ec_array = ec_array[:,2:end]
pc_array = pc_array[:,2:end]

# Re-rank -
rank_array = rank_function(ec_array)

# Write -
writedlm("./data/ec_array.dat",ec_array)
writedlm("./data/pc_array.dat",pc_array)
writedlm("./data/rank_array.dat",rank_array)
