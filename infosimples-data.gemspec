
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "infosimples/data/version"

Gem::Specification.new do |spec|
  spec.name          = "infosimples-data"
  spec.version       = Infosimples::Data::VERSION
  spec.authors       = ["Infosimples"]
  spec.email         = ["team@infosimples.com.br"]

  spec.summary       = %q{Ruby API for Infosimples::Data (https://infosimples.com/)}
  spec.description   = %q{Infosimples::Data allows you to automate web site navigation.}
  spec.homepage      = "https://github.com/infosimples/infosimples-data"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
