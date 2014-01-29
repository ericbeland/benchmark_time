require 'bundler/setup'
require "benchmark_time"
require 'mocha/api'

RSpec.configure do |config|
 
end

def capture_stdout &block
  old_stdout = $stdout
  fake_stdout = StringIO.new
  $stdout = fake_stdout
  block.call
  fake_stdout.string
ensure
  $stdout = old_stdout
end