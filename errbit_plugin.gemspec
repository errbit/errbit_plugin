# frozen_string_literal: true

require_relative "lib/errbit_plugin/version"

Gem::Specification.new do |spec|
  spec.name = "errbit_plugin"
  spec.version = ErrbitPlugin::VERSION
  spec.authors = ["Stephen Crosby"]
  spec.email = ["stevecrozz@gmail.com"]

  spec.summary = "Base to create an errbit plugin"
  spec.description = "Base to create an errbit plugin"
  spec.homepage = "https://github.com/errbit/errbit_plugin"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
