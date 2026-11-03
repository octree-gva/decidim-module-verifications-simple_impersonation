# frozen_string_literal: true

require "decidim/dev/common_rake"

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rails db:seed")
  end
end

# --demo copies initiative signature handlers that eager-load Decidim::Initiatives.
# This Gemfile does not load that component. The authorization view spec only needs DummyAuthorizationHandler.
def remove_initiatives_demo_files(app_root)
  relatives = [
    "app/services/dummy_signature_handler.rb",
    "app/services/dummy_sms_mobile_phone_validator.rb",
    "config/initializers/decidim_initiatives.rb",
    "app/views/decidim/initiatives"
  ]
  relatives.each { |relative| FileUtils.rm_rf(File.join(app_root, relative)) }
end

desc "Prepare for testing"
task :prepare_tests do
  # Remove previous existing db, and recreate one.
  disable_docker_compose = ENV.fetch("DISABLED_DOCKER_COMPOSE", "false") == "true"
  unless disable_docker_compose
    system("docker-compose -f docker-compose.yml down -v --remove-orphans")
    system("docker-compose -f docker-compose.yml up -d ")
  end
  ENV["RAILS_ENV"] = "development"
  common_db_config = {
    "adapter" => "postgresql",
    "encoding" => "unicode",
    "host" => ENV.fetch("DATABASE_HOST", "simple-impersonation-pg"),
    "port" => ENV.fetch("DATABASE_PORT", "5432").to_i,
    "username" => ENV.fetch("DATABASE_USERNAME", "decidim"),
    "password" => ENV.fetch("DATABASE_PASSWORD", "pleaseChangeMe"),
    "database" => "#{base_app_name}_test_app"
  }

  database_yml = {
    "test" => common_db_config,
    "development" => common_db_config
  }

  config_file = File.expand_path("spec/decidim_dummy_app/config/database.yml", __dir__)
  File.open(config_file, "w") { |f| YAML.dump(database_yml, f) }
  Dir.chdir("spec/decidim_dummy_app") do
    system("bundle exec rails db:drop")
    system("bundle exec rails db:create")
    system("bundle exec rails db:migrate")
  end
end

desc "Generates a dummy app for testing"
task :test_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "spec/decidim_dummy_app",
      "--app_name",
      "#{base_app_name}_test_app",
      "--path",
      "../..",
      "--skip_spring",
      "--demo",
      "--force_ssl",
      "false",
      "--locales",
      "en,fr,es"
    )
  end
  remove_initiatives_demo_files(File.expand_path("spec/decidim_dummy_app", __dir__))
  Rake::Task["prepare_tests"].invoke
end

desc "Generates a development app"
task :development_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      "..",
      "--recreate_db",
      "--demo"
    )
  end
end
