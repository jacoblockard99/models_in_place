# frozen_string_literal: true

require_relative 'lib/models_in_place/version'

Gem::Specification.new do |spec|
  spec.name        = 'models_in_place'
  spec.version     = ModelsInPlace::VERSION
  spec.authors     = ['Jacob']
  spec.email       = ['jacoblockard99@gmail.com']
  spec.homepage    = 'https://github.com/jacoblockard99/models_in_place'
  spec.summary     = 'An edit_in_place extension with sensible defaults.'
  spec.description = <<~DESC
    Models_in_place is an extension for edit_in_place that provides sensible defaults if you are
    working within a model-like system for storing and manipulating editable data.
  DESC
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jacoblockard99/models_in_place'
  # spec.metadata["changelog_uri"] = "TODO"

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'deep_merge', '~> 1.2'
  spec.add_dependency 'edit_in_place', '0.1.0'
  spec.add_dependency 'rails', '~> 6.1.4'

  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'rspec-rails', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 1.18'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.4'
  spec.add_development_dependency 'simplecov', '0.17'
end
