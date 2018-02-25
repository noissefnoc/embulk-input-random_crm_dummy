
Gem::Specification.new do |spec|
  spec.name          = "embulk-input-random_crm_dummy"
  spec.version       = "0.1.0"
  spec.authors       = ["Kota SAITO"]
  spec.summary       = "Crm Dummy input plugin for Embulk"
  spec.description   = "Loads records from Crm Dummy."
  spec.email         = ["noissefnoc@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/noissefnoc/embulk-input-crm_dummy"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faker', ['>=1.8.7']

  spec.add_development_dependency 'embulk', ['>= 0.8.39']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'test-unit-rr'
  spec.add_development_dependency 'rr'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'everyleaf-embulk_helper'
end
