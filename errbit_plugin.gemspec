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

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(["git", "ls-files", "-z"], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?("bin/", "test/", "spec/", "features/", ".git", ".github", "appveyor", "Gemfile")
    end
  end
  spec.require_paths = ["lib"]
end
