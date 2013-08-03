# BenchmarkTime

Benchmark the execution time of an arbitrary block of code. Specify concurrent
threads and number of execution loops for more robust sampling.

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
