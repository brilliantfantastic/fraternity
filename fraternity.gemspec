# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fraternity/version'

Gem::Specification.new do |spec|
  spec.name          = "fraternity"
  spec.version       = Fraternity::VERSION

  spec.authors       = ["Jamie Wright"]
  spec.email         = ["jamie@brilliantfantastic.com"]

  spec.summary       = "An easier way to rush for a beta"
  spec.description   = %q{
                        Collect and store a list of pledges who would like access to your beta. You can send out bids to those
                        pledges and allow them to gain access to your beta.
                       }

  spec.homepage      = "http://github.com/brilliantfantastic/fraternity"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"
  spec.add_dependency "lotus-model"
  spec.add_dependency "lotus-validations"
end
