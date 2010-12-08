# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bucketface/version"

Gem::Specification.new do |s|
  s.name        = "bucketface"
  s.version     = Bucketface::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rafael George"]
  s.email       = ["george.rafael@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Provides a wrapper for Bitbucket API}
  s.description = %q{Provides a wrapper for Bitbucket API}

  s.rubyforge_project = "bucketface"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('fakeweb', '~> 1.3')
  s.add_development_dependency('jnunemaker-matchy', '~> 0.4.0')
  s.add_development_dependency('mocha', '~> 0.9')
  s.add_development_dependency('shoulda', '~> 2.11')
  s.add_runtime_dependency('hashie', '~> 0.4.0')
  s.add_runtime_dependency('httparty', '~> 0.6.1')
end
