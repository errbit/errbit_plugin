lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'errbit_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = "errbit_plugin"
  spec.version       = ErrbitPlugin::VERSION
  spec.authors       = ["Stephen Crosby"]
  spec.email         = ["stevecrozz@gmail.com"]
  spec.description   = %q{Base to create an errbit plugin}
  spec.summary       = %q{Base to create an errbit plugin}
  spec.homepage      = "http://github.com/errbit/errbit"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
