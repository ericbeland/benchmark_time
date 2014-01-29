require "bunny"
require_relative "../lib/benchmark_time"


benchmark_time(threads: 10, loops: 2) do
 # thing to benchmark goes here...

 
end