# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'DataStructsAndAlgos/Ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "DataStructsAndAlgos-Ruby"
  spec.version       = DataStructsAndAlgos::Ruby::VERSION
  spec.authors       = ["Jboy Flaga"]
  spec.email         = ["jeremiahflaga@gmail.com"]
  spec.description   = %q{Jboy's implementation of some data structures and algorithms using Ruby}
  spec.summary       = %q{Jboy's implementation of some data structures and algorithms using Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.required_ruby_version = ">=1.9"
end
