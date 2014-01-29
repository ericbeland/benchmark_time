# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'benchmark_time/version'

Gem::Specification.new do |spec|
  spec.name          = "benchmark_time"
  spec.version       = BenchmarkTime::VERSION
  spec.authors       = ["ebeland"]
  spec.email         = ["ebeland@gmail.com"]
  spec.description   = %q{Quickly benchmark functionality from the command line}
  spec.summary       = %q{Run and benchmark a ruby block with min/max/avg}
  spec.homepage      = "http://github.com/ericbeland"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
