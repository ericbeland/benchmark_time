require_relative "../lib/benchmark_time"

benchmark_time(num_threads: 10, num_loops: 2, print_samples: true) do
 sleep 1.00
end