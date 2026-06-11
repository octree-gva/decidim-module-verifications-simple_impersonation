# frozen_string_literal: true

source "https://rubygems.org"

base_path = "./"
base_path = "../../" if File.basename(__dir__) == "decidim_dummy_app"
base_path = "../" if File.basename(__dir__) == "development_app"

require_relative "#{base_path}lib/decidim/verifications/simple_impersonation/version"

DECIDIM_VERSION = "~> 0.29.1"

gem "bootsnap", "~> 1.4"
gem "decidim", DECIDIM_VERSION
gem "decidim-verifications-simple_impersonation", path: base_path
gem "puma", ">= 6.3.1"
gem "uglifier", "~> 4.1"
gem "uri", "1.1.1"

group :development, :test do
  gem "brakeman", "~> 6.1"
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "parallel_tests", "~> 4.2"
end

group :test do
  gem "capybara", "~> 3.24"
  gem "rspec-rails", "~> 6.0"
  gem "rubocop-faker"
end

group :development do
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "web-console", "~> 4.2"
end

gem "concurrent-ruby", "= 1.3.4"
