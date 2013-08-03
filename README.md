# BenchmarkTime

Benchmark the execution time of an arbitrary block of code. Specify concurrent
threads and number of execution loops.

## Installation

Add this line to your application's Gemfile:

    gem 'benchmark_time'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install benchmark_time

## Usage

  require 'benchmark_time'
  require 'bunny'

    # Benchmark connecting and filing an item into rabbitmq with bunny
    benchmark_time(num_threads: 10, num_loops: 5) do
      conn = Bunny.new
      conn.start
      ch  = conn.create_channel
      q   = ch.queue("test1")
      q.publish('hello bunny')
      conn.stop
    end

  ->
  --------------------------------------------------------------

  Samples:                    50

  Min time (ms):              6

  Max time (ms):              157

  Average time (ms):          32.6

  Standard Deviation (ms):    25.33046886777315

  --------------------------------------------------------------



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
