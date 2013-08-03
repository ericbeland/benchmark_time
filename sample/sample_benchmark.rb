require_relative "../lib/benchmark_time"

benchmark_time(threads: 10, loops: 2, print_samples: true) do
 sleep 1.00
end