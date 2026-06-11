# frozen_string_literal: true

require "decidim/gem_manager"

namespace :decidim_verifications_simple_impersonation do
  namespace :webpacker do
    desc "Installs Simple Impersonation verification webpacker files in Rails instance application"
    task install: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_verifications_simple_impersonation_npm
    end

    desc "Adds Simple Impersonation verification dependencies in package.json"
    task upgrade: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_verifications_simple_impersonation_npm
    end

    def install_verifications_simple_impersonation_npm
      return if verifications_simple_impersonation_npm_dependencies.empty?

      puts "install NPM packages. You can also do this manually with this command:"
      puts "npm i #{verifications_simple_impersonation_npm_dependencies.join(" ")}"
      verifications_simple_impersonation_system! "npm i #{verifications_simple_impersonation_npm_dependencies.join(" ")}"
    end

    def verifications_simple_impersonation_npm_dependencies
      @verifications_simple_impersonation_npm_dependencies ||=
        if verifications_simple_impersonation_path.nil? ||
           !File.exist?(verifications_simple_impersonation_path.join("package.json"))
          []
        else
          package_json = JSON.parse(File.read(verifications_simple_impersonation_path.join("package.json")))
          (package_json["dependencies"] || {}).map { |package, version| "#{package}@#{version}" }
        end
    end

    def verifications_simple_impersonation_path
      gem_name = verifications_simple_impersonation_gem_name
      return @verifications_simple_impersonation_path if defined?(@verifications_simple_impersonation_path)
      return unless Gem.loaded_specs.has_key?(gem_name)

      @verifications_simple_impersonation_path =
        Pathname.new(verifications_simple_impersonation_gemspec.full_gem_path)
    end

    def rails_app_path
      @rails_app_path ||= Rails.root
    end

    def verifications_simple_impersonation_system!(command)
      system("cd #{rails_app_path} && #{command}") || abort("\n== Command #{command} failed ==")
    end

    def verifications_simple_impersonation_gemspec
      @verifications_simple_impersonation_gemspec ||= Gem.loaded_specs[verifications_simple_impersonation_gem_name]
    end

    def verifications_simple_impersonation_gem_name
      "decidim-verifications-simple_impersonation"
    end
  end
end
