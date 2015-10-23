# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'assume_role/version'

Gem::Specification.new do |spec|
  spec.name          = "assume_role"
  spec.version       = AssumeRole::VERSION
  spec.authors       = ["clairvy"]
  spec.email         = ["clairvy@gmail.com"]
  spec.summary       = %q{do AssumeRole command like sudo.}
  spec.description   = %q{do AssumeRole command like sudo.}
  spec.homepage      = "http://github.com/clairvy/assume_role"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_dependency "aws_config"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
