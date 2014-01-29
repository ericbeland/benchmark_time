# BenchmarkTime

Benchmark the execution time of an arbitrary block of code. Specify concurrent
threads and number of execution loops for more robust sampling. 

BenchmarkTime is especially built to benchmark things like external services, 
rather than ruby code itself. It can do something like a small scale 
load test of external dependencies.

## Installation

Add this line to your application's Gemfile:

    gem 'benchmark_time'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install benchmark_time

## Usage
  require 'benchmark_time'

    benchmark_time(threads: 10, loops: 2) do
      conn = Bunny.new
      conn.start
      ch  = conn.create_channel
      q   = ch.queue("test1")
      q.publish(@data)
      conn.stop
    end

  ->

  "----------------------------------------"
  "Samples:               20"
  "Min time:              0.059449195861816406"
  "Max time:              0.15325689315795898"
  "Average time:          0.10354292392730713"
  "Standard Deviation:    0.027390028761805192"
  "----------------------------------------"

  # Options for benchmark_time:

      :work_warmup_proc A proc to call for each thread. this can pre-warm connections, 
      or perform oother non-timed work.
      
      :num_threads        Number of concurrent threads to execute the work
      :num_loops          Number of times to call the block in each execution thread.
      :loop_delay          Delay after each loop. (defaults to 0)
      :show_values         If output is printed, display array of actual varia values (good at small scale)
      :print_results       If true, puts the result to sdtout at the end.
      :garbage_collection  If false (default) garbage colleciton will be off during the loop to benchmark.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request