# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riskguard_migrator/version'

Gem::Specification.new do |spec|
  spec.name          = "riskguard_migrator"
  spec.version       = RiskguardMigrator::VERSION
  spec.authors       = ["Alfredo E. Rico Moros"]
  spec.email         = ["alfredorico@gmail.com"]
  spec.license       = "MIT"
  spec.summary       = "Migrador Riskguard"
  spec.description   = %q{ Migrador de la base de datos riskguard para los cliente actuales a la nueva base de datos 
                           de la nueva versión ersión.
                         }
  spec.homepage      = "http://dacrt.com"

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
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency 'activerecord', '4.2.7.1'
  spec.add_dependency 'pg','0.18.4'

end
