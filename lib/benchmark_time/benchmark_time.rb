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
      # +:num_threads+        Number of concurrent threads to execute the work
      # +:num_loops+          Number of times to call the block in each execution thread.
      # +:loop_delay          Delay after each loop. (defaults to 0)
      # 
      # +:show_values+         If output is printed, display array of actual variable values (good at small scale)
      # +:print_results+       If true, puts the result to sdtout at the end.
      # +:garbage_collection+  If false (default) garbage colleciton will be off during the loop to benchmark.


    def initialize(options = {}, &work_block)
      default_options = { num_threads:          10, 
                          num_loops:            10, 
                          loop_delay:           0,
                          show_values:          true, 
                          print_results:        true,
                          garbage_collection:   false,
                          work_warmup_proc:     nil, 
                        }

      options = default_options.merge(options)
      options.to_instance_variables(binding, define: :attr_reader)
      @threads            = []
      @results            = []
      @work_block         = work_block
      @results.extend(EnumerableStatistics)
    end

    # Returns a time for an arbitrary block's execution
    def time_operation(&block)
      start = Time.now.to_ms
      yield
      Time.now.to_ms - start
    end

    # Prints benchmark results to stdout.
    def display_results(result_array)
      puts "------------------- Completed run ----------------------------"
      puts "Samples:               #{result_array.length}"
      puts "Min time:              #{result_array.min}"
      puts "Max time:              #{result_array.max}"
      puts "Average time:          #{result_array.mean}"
      puts "Standard Deviation:    #{result_array.standard_deviation}"
      puts "Values:                #{result_array.inspect}" if @show_values
      puts "--------------------------------------------------------------"
    end

    # Performs a multi-threaded execution of the block as specified in the initializer
    def run
      puts "Starting run with #{@num_threads} threads looping #{@num_loops} times" if @print_results 
      @num_threads.times do 
        @threads << Thread.new do |th|
          @num_loops.times do
            @results << time_operation do 
              @work_warmup_proc.call if @work_warmup_proc
              result = @work_block.call 
              sleep @loop_delay
              result
            end
          end
        end
      end
      GC.disable unless @garbage_collection
      @threads.each {|th| th.join }
      GC.enable
      display_results(@results) if @print_results 
      @results
    end

  end

end

# an easy wrapper to do the bem
def benchmark_time(*args, &block)
  b = BenchmarkTime::BenchmarkTime.new(*args, &block)
  b.run
end
