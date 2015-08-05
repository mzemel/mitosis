# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mitosis/version'

Gem::Specification.new do |spec|
  spec.name          = "mitosis"
  spec.version       = Mitosis::VERSION
  spec.authors       = ["Michael Zemel"]
  spec.email         = ["mzemel@sweetspotdiabetes.com"]

  spec.summary       = "Mitosis is a rubygem to publish your errors to a message queue"
  spec.description   = "Use this gem with an HTML page that subscribes to Disque or Redis to see real-time errors"
  spec.homepage      = "http://sweetspotdiabetes.com"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "config"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "disque"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

end
