require_relative "enumerable_statistics"

module BenchmarkTime
  # A simple time-based benchmarking script for the command line.
  class BenchmarkTime

    # announce if we have an exception
    Thread.abort_on_exception = true

    # ==== Arguments
    #
    # +&work_block+    The actual work to be performed
    #
    # Create and run a new benchmark with output to the command line
    # ==== Options
      # +:work_warmup_proc:+ A proc to call for each thread. this can pre-warm connections, 
      # or perform oother non-timed work.
      # +:threads+  Number of concurrent threads to execute the work
      # +:loops+    Number of times to call the block in each execution thread.
    def initialize(options = {}, &work_block)
      default_options = {num_threads: 10, num_loops: 10, print_samples: true, work_warmup_proc: nil}
      options = default_options.merge(options)
      # experiment: auto-create instance variables from hash...
      options.to_instance_variables(binding, define: :attr_reader) 
      @threads            = []
      @results            = []
      @results.extend(EnumerableStatistics)
      @work_block         = work_block
      run
    end

    # Returns a time for an arbitrary block's execution
    def time_operation(&block)
      start = Time.now.to_ms
      yield
      Time.now.to_ms - start
    end

    # Prints benchmark results to stdout.
    def display_results(result_array)
      puts result_array.inspect if @print_samples
      puts "--------------------------------------------------------------"
      puts "Samples:                    #{result_array.length}"
      puts "Min time (ms):              #{result_array.min}"
      puts "Max time (ms):              #{result_array.max}"
      puts "Average time (ms):          #{result_array.mean}"
      puts "Standard Deviation (ms):    #{result_array.standard_deviation}"
      puts "--------------------------------------------------------------"
    end

    # Performs a multi-threaded execution of the block as specified in the initializer
    def run
      puts "Starting run with #{@num_threads} threads looping #{@num_loops} times"
      @num_threads.times do 
        @threads << Thread.new do |th|
          @num_loops.times do
            @results << time_operation do 
              @work_warmup_proc.call if @work_warmup_proc
              @work_block.call 
            end
          end
        end
      end
      @threads.each {|th| th.join }
      puts "Completed run"
      display_results(@results)
    end

  end

end

# an easy wrapper to do the bem
def benchmark_time(*args, &block)
  ::BenchmarkTime::BenchmarkTime.new(*args, &block)
end
