# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'new_relic/presto/version'

Gem::Specification.new do |spec|
  spec.name          = 'newrelic_presto'
  spec.version       = NewRelic::Presto::VERSION
  spec.authors       = ['Huang Bin']
  spec.email         = ['huangbin88@foxmail.com']

  spec.summary       = 'Presto NewRelic'
  spec.description   = 'Presto Instrumentation for NewRelic'
  spec.homepage      = 'https://github.com/hbin/newrelic-presto'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'presto-client'
  spec.add_runtime_dependency 'newrelic_rpm'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
