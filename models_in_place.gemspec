require_relative "lib/models_in_place/version"

Gem::Specification.new do |spec|
  spec.name        = "models_in_place"
  spec.version     = ModelsInPlace::VERSION
  spec.authors     = ["Jacob"]
  spec.email       = ["jacoblockard99@gmail.com"]
  spec.homepage    = "TODO"
  spec.summary     = "TODO: Summary of ModelsInPlace."
  spec.description = "TODO: Description of ModelsInPlace."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4"
end
