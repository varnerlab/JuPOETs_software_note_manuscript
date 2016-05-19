# Run the model for the ensemble of solutions -

# Load the ensemble files from disk -
pc_array_full = load("./data/pc_array.dat")
rank_array = load("./data/rank_array.dat")

idx_rank = find(rank_array==0)
