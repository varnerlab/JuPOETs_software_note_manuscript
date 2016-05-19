% Octave script to nake performannce plot -

% Load the data -
data_array = load("performance.dat")

# make groups -
hold on
bar(data_array(:,1))

# Generate SF -
SF = 2.678/sqrt(10)

# make error bars -
h = errorbar(data_array(:,1),SF*data_array(:,2),'k.')
set(h,"linestyle","none")
