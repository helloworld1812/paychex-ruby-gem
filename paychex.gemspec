lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paychex/version'

Gem::Specification.new do |spec|
  spec.name          = "paychex"
  spec.version       = Paychex::VERSION
  spec.authors       = ["Mayank Dedhia"]
  spec.email         = ["mayankdedhia@gmail.com"]

  spec.summary       = %q{Ruby wrapper for paychex.com APIs.}
  spec.description   = "A Ruby wrapper for wotc.com REST APIs which will make \
    it easy to interact with Paychex."
  spec.homepage      = "https://github.com/helloworld1812/paychex-ruby-gem"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Currently no push is allowed
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/helloworld1812/paychex-ruby-gem"
  spec.metadata["changelog_uri"] = "https://github.com/helloworld1812/paychex-ruby-gem/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", ">= 3.9.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "webmock"
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'faraday_middleware'
end
