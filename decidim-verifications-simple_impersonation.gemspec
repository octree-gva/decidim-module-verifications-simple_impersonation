# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/verifications/simple_impersonation/version"

Gem::Specification.new do |s|
  s.version = Decidim::Verifications::SimpleImpersonation.version
  s.authors = ["Hadrien Froger"]
  s.email = ["hadrien@octree.ch"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/octree-gva/decidim-verifications-simple_impersonation"
  s.required_ruby_version = ">= 3.2.2"

  s.name = "decidim-verifications-simple_impersonation"
  s.summary = "A decidim impersonation verification flow"
  s.description = "Add a verification for impersonation only."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]
  s.require_paths = ["lib"]

  s.add_dependency "decidim-admin", Decidim::Verifications::SimpleImpersonation.decidim_version
  s.add_dependency "decidim-core", Decidim::Verifications::SimpleImpersonation.decidim_version
  s.add_dependency "decidim-verifications", Decidim::Verifications::SimpleImpersonation.decidim_version
  s.metadata["rubygems_mfa_required"] = "true"
end
