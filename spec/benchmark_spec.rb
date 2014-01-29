require_relative "spec_helper"

describe 'benchmark_time' do

  it "should return an array with results" do
    results = benchmark_time(num_threads: 1, num_loops: 2) { }
    results.length.should == 2    
    results = benchmark_time(num_threads: 4, num_loops: 4) { }
    results.length.should == 16 
  end

  it "should return min/max/average" do
    results = benchmark_time(num_threads: 1, num_loops: 2) { }
    (results.min    >= 0).should be_true
    (results.max    >= 0).should be_true
    (results.mean   >= 0).should be_true
  end

  it "should print values if true" do
    output = capture_stdout do
      benchmark_time(num_threads: 1, num_loops: 1) {}
    end
    (output =~ /Values/).should be_true
  end

  it "should print min/max/average if printing output" do
    output = capture_stdout do
      benchmark_time(num_threads: 1, num_loops: 2) {}
    end
    (output =~ /min time/i).should be_true
    (output =~ /max time/i).should be_true
    (output =~ /average time/i).should be_true
  end

  it "should not print anything if printing output is disabled" do
    output = capture_stdout do
      benchmark_time(num_threads: 1, num_loops: 2, print_results: false) {}
    end
    output.empty?.should be_true
  end

  it "should disable garbage collection if off" do
    GC.expects(:disable).once.returns(true)
    results = benchmark_time(num_threads: 2, num_loops: 1, garbage_collection: false) { }
    GC.unstub(:disable)
  end

  it "should not disable garbage collection if off" do
    GC.expects(:disable).never.returns(true)
    results = benchmark_time(num_threads: 2, num_loops: 1, garbage_collection: true) { }
    GC.unstub(:disable)
  end

end