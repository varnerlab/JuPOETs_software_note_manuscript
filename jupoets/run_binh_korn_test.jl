include("test_binh_korn.jl")


number_of_trials = 10
etime_array = zeros(number_of_trials)
for index in collect(1:number_of_trials)

  tic()
  test_binh_korn()
  elapsed_time = toc()
  etime_array[index] = elapsed_time

end