# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "rosumi"
  spec.version       = "0.0.1"
  spec.authors       = ["Kevin Eder"]
  spec.email         = ["kevin.eder@gmail.com"]
  spec.description   = %q{Provides an API for locating and messaging Apple devices.}
  spec.summary       = %q{Provides an API for locating and messaging Apple devices.}
  spec.homepage      = "https://github.com/kevineder/rosumi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
