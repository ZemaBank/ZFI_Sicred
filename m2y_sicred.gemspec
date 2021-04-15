lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'm2y_sicred/version'

Gem::Specification.new do |spec|
  spec.name          = 'm2y_sicred'
  spec.version       = M2ySicred::VERSION
  spec.authors       = ['Danilo Sobral']
  spec.email         = ['danilo.sobral@mobile2you.com.br']

  spec.summary       = "Sicred API Gem - #{spec.version}"
  spec.description   = 'Sicred API Gem'
  spec.homepage      = 'http://www.mobile2you.com.br'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir['lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'httparty'
end
