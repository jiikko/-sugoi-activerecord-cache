# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sugoi_activerecord_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "sugoi_activerecord_cache"
  spec.version       = SugoiActiverecordCache::VERSION
  spec.authors       = ["jiikko"]
  spec.email         = ["n905i.1214@gmail.com"]

  spec.summary       = %q{This gem provides cache for activerecord.}
  spec.description   = %q{This gem provides cache for activerecord.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activerecord", "~> 3.0"
end
