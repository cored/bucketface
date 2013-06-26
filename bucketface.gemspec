# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bucketface/version'

Gem::Specification.new do |spec|
  spec.name          = "bucketface"
  spec.version       = Bucketface::VERSION
  spec.authors       = ["Rafael George"]
  spec.email         = ["george.rafael@gmail.com"]
  spec.description   = %q{Ruby wrapper for the Bitbucket API}
  spec.summary       = %q{Ruby wrapper for the Bitbucket API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
end
